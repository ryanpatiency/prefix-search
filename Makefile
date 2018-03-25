TESTS = \
    test_cpy \
    test_ref

CFLAGS = -Wall -Werror -g

# Control the build verbosity                                                   
ifeq ("$(VERBOSE)","1")
    Q :=
    VECHO = @true
else
    Q := @
    VECHO = @printf
endif

GIT_HOOKS := .git/hooks/applied

.PHONY: all clean

all: $(GIT_HOOKS) $(TESTS)

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo


OBJS := \
    tst_cpy.o \
    tst_ref.o \
    test_cpy.o \
    test_ref.o

deps := $(OBJS:%.o=.%.o.d)

test_%: test_%.o tst_%.o
	$(VECHO) "  LD\t$@\n"
	$(Q)$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(VECHO) "  CC\t$@\n"
	$(Q)$(CC) -o $@ $(CFLAGS) -c -MMD -MF .$@.d $<

bench:
	 echo 3 | sudo tee /proc/sys/vm/drop_caches
	./test_ref < command.txt
	 echo 3 | sudo tee /proc/sys/vm/drop_caches
	./test_cpy < command.txt

clean:
	$(RM) $(TESTS) $(OBJS)
	$(RM) $(deps)

-include $(deps)
