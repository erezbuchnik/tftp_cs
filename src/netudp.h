/* netudp.h 
   Copyright (c) 2013 James Northway
*/

#ifndef TFTP_NETUDP
#define TFTP_NETUDP

#include <sys/socket.h>

void netudp_set_options(int csum_calc_off, int *ssock);
void netudp_bind_server(int *ssock, char *port);
void netudp_rebind_server(int *ssock, char *port2);
void netudp_bind_client(int *ssock, char *server, char *port);
void netudp_send_packet(int *ssock, struct sockaddr* dest, 
    packetbuffer_t **packet_out, int *length);

#endif
