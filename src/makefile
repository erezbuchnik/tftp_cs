CC = gcc
CFLAGS = -ansi -Wall -D_POSIX_C_SOURCE
COMMON = file.c fsm.c netudp.c tftp.c

all: tftp_clnt tftp_srvr

tftp_srvr:
	$(CC) $(CFLAGS) server.c $(COMMON) -o tftp_srvr
tftp_clnt: 
	$(CC) $(CFLAGS) client.c $(COMMON) -o tftp_clnt

clean:
	rm tftp_clnt
	rm tftp_srvr
    
