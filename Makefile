APP_NAME = main

ifeq ($(OS),WINDOWS)
  WINFLAG=1
else
  ifeq ($(findstring Windows, $(OS)),Windows)
    WINFLAG=1
  else
    WINFLAG=0
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
      LIBS += -lpthread
    endif
    ifeq ($(UNAME_S),Darwin)
      LIBS +=
    endif
  endif
endif


XSCOPE_HOST_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

INCLUDES += -I$(XSCOPE_HOST_DIR)

SOURCES += $(XSCOPE_HOST_DIR)/xscope_host_shared.c $(XSCOPE_HOST_DIR)/mutex.c $(XSCOPE_HOST_DIR)/queues.c
ifeq ($(WINFLAG),1)
  SOURCES += $(XSCOPE_HOST_DIR)/getopt.c $(XSCOPE_HOST_DIR)/inet_pton.c
endif


ifeq ($(WINFLAG),1)

SHELL = c:\Windows\system32\cmd.exe

all:
	cl $(FLAGS) $(APP_NAME).c $(INCLUDES) $(SOURCES)

clean:
	del $(APP_NAME).exe *.obj

else

all:
	gcc $(FLAGS) $(APP_NAME).c $(INCLUDES) $(SOURCES) -o $(APP_NAME) $(LIBS)

clean:
	rm -f $(APP_NAME)

endif
