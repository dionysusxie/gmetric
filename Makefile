TARGET = app

NON_MAIN_OBJECT_FILES = embeddedgmetric.o modp_numtoa.o

OBJECT_FILES = $(NON_MAIN_OBJECT_FILES) main.o

LIB_DIR = /usr/local/lib

CXXFLAGS = -Wall -c -g

LDFLAGS = -L$(LIB_DIR)
LDFLAGS += -Wl,-E

CC = g++

.PHONY: clean

all: $(TARGET)

$(TARGET): $(OBJECT_FILES)
	$(CC) -o $(TARGET) $(OBJECT_FILES) $(LDFLAGS)
	@echo "Build successfully!"

%.o : %.c
	$(CC) $(CXXFLAGS) $*.c -o $*.o
	$(CC) $(CXXFLAGS) -MM $*.c > $*.d
	@mv -f $*.d $*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $*.d.tmp > $*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $*.d
	@rm -f $*.d.tmp

%.o : %.cpp
	$(CC) $(CXXFLAGS) $*.cpp -o $*.o
	$(CC) $(CXXFLAGS) -MM $*.cpp > $*.d
	@mv -f $*.d $*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $*.d.tmp > $*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $*.d
	@rm -f $*.d.tmp

-include $(OBJECT_FILES:.o=.d)

clean:
	rm -rf $(TARGET) *.o *.d
