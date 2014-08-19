#include "xscope_host_shared.h"

// Called with the registartions so that the app can map name->probe
void hook_registration_received(int sockfd, int xscope_probe, char *name) {
	printf("Socket file descriptor: %d; XScope probe number: %d; Name: %s\n", sockfd, xscope_probe, name);
}

// Called whenever data is received from the target
void hook_data_received(int sockfd, int xscope_probe, void *data, int data_len) {
	int *int_data = (int*)data;
	printf("Socket file descriptor: %d; XScope probe number: %d; Data length: %d; Data:%d\n", sockfd, xscope_probe, data_len, int_data[0]);
}

// Called whenever the application is existing
void hook_exiting() {

}

int main(int argc, char* argv[]) {
	int fds[1];

	fds[0] = initialise_socket("127.0.0.1", "10101");

	handle_sockets(fds, 1);

	return 0;
}
