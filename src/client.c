/* client.c 
   Copyright (c) 2013 James Northway
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <signal.h>
#include <string.h>
#include <unistd.h>
#include "file.h"
#include "fsm.h"
#include "netudp.h"
#include "tftp.h"

/* From netudp.c */
extern struct sockaddr_in xfSrv, xfCli;
extern struct sockaddr_in ftCli, ftSrv; 

/* Sockets, Ports, Addresses */
int socket1;
int addrlen;
char *port;
int socket2;
int port2;

/* From tftp.c */
extern packetbuffer_t packet_in_buffer[PACKETSIZE];
extern packetbuffer_t *packet_in;
extern int packet_in_length;
extern struct tftp_packet packet;
extern struct tftp_transaction transaction;
extern packetbuffer_t * packet_out;
extern int packet_out_length;

/* State Functions */
void state_send(int *operation);
void state_wait(int *operation);
void state_receive(int *operation);

/* State Helper Functions */
static void wait_alarm(int);

/* Command Line Arguments */
char *command;
char *server;
char *filename;
char *outfilename;

/* CLIENT PROGRAM */
int main (int argc, char *argv[]){
   
    if (argc < 6) {
        fprintf(stderr, 
        "Usage: %s <server ip> <port> <filename> <output filename> [get|put]\n",
        argv[0]);
        exit(1);
    }

    int state = STATE_SEND;
    int operation;
    server = argv[1];
    port = argv[2]; 
    filename = argv[3];
    outfilename = argv[4];
    command = argv[5];
    transaction.timeout_count = 0;
    transaction.blocknum = 0;
    transaction.final_packet = 0;
    transaction.file_open = 0;
    transaction.complete = 0;
    transaction.rebound_socket = 0;
    transaction.ecode = ECODE_NONE;
    packet_in_length = 0;
    transaction.filepos = 0;
    strcpy(transaction.mode, MODE_NETASCII);
    netudp_bind_client(&socket1, server, port);
    
    if ((strncmp(command,"get",3)) == 0){
        packet_free();
        packet_form_rrq(filename);
        transaction.blocknum = 1;
        
        if (file_open_write(outfilename,&transaction.filedata) == -1){
            fprintf(stderr,"Could not open output file.\n");
            exit(1);
        }
        
        transaction.file_open = 1;       
    }else if((strncmp(command,"put",3)) == 0){
        
        if (transaction.file_open == 1){
            file_close(&transaction.filedata);
        }
        
        if ((file_open_read(filename,&transaction.filedata))== -1){
            exit(1);           
        }else{
            transaction.file_open = 1;
            packet_free();
            packet_form_wrq(outfilename);
        }       
    }else{
        printf("'%s' is not a valid command. Use 'get' or 'put'.\n",command);
        exit(1);
    }

    while (state != STATE_FINISHED){
    
        switch(state) {
            case STATE_SEND:
                state_send(&operation);
            break;
            case STATE_WAIT:
                state_wait(&operation);
            break;
            case STATE_RECEIVE:
                state_receive(&operation);
            break;
        }
        
        client_fsm(&state, &operation);
    }
    
    printf("\n");
    
    if (transaction.complete == 1){
        printf("Transfer completed.");        
    }else{
        printf("Transfer failed.");
    }
    
    printf("\n");
    return 0;
}

/* STATE FUNCTIONS */
void state_send(int *operation){
    netudp_send_packet(&socket1, (struct sockaddr *) &ftSrv, &packet_out,
        &packet_out_length);
    
    if (transaction.complete == 1 || transaction.ecode != ECODE_NONE){
        *operation = OPERATION_ABANDONED;        
    }else{
        *operation = OPERATION_DONE;
    }
}

void state_wait(int *operation){
    int rbytes = 0;
    transaction.timed_out = 0;
    struct sigaction sa;
    memset (&sa, '\0', sizeof(sa));
    sa.sa_handler = (void(*)(int)) wait_alarm;
    sigemptyset(&sa.sa_mask);
    int res = sigaction(SIGALRM, &sa, NULL);
    
    if (res == -1) {
        fprintf(stderr, "Unable to set SA_RESTART to false: %s\n",
                        strerror(errno));
        abort();
    }

    alarm(TIMEOUT);
    addrlen = sizeof(struct sockaddr);

    if((rbytes = recvfrom(socket1, packet_in, PACKETSIZE, 0,
            (struct sockaddr *)&ftSrv, (socklen_t *) &addrlen)) < 0){
        
        if ((errno == EINTR) && transaction.timed_out) {
            transaction.timeout_count++;          
        }else{
            fprintf(stderr, "%s\n", strerror(errno));
        }
        
        if (transaction.timeout_count == TIMEOUT_LIMIT){
            fprintf(stderr, "Timeout.\n");
            *operation = OPERATION_ABANDONED;           
        }else{
            *operation = OPERATION_FAILED;
        }       
    }else{
        alarm(0);
        transaction.timeout_count = 0;
        packet_in_length = rbytes;
        *operation = OPERATION_DONE;
    } 
}

void state_receive(int *operation){
    packet_parse(&packet, packet_in, &packet_in_length);
    
    if (IS_DATA(packet.opcode)){
        *operation = packet_receive_data();
        
    }else if (IS_ACK(packet.opcode)){
        *operation = packet_receive_ack();
        
    }else if (IS_ERROR(packet.opcode)){
        *operation = packet_receive_error();
        
    }else{
        *operation = packet_receive_invalid();
    }
}

static void wait_alarm(int signo){
    transaction.timed_out = 1;
    signo++;
    return;
}
