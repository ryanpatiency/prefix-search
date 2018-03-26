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

bench-loadtime:
	./scripts/measure_load_time.sh

gen-cmd:
	gcc -o gen_cmd gen_cmd.c && ./gen_cmd

gen-freq:
	gcc -o gen_freq gen_freq.c && ./gen_freq
	
plot-freq: gen-freq
	gnuplot ./scripts/freq.gp && eog ./freq.png

style:
	astyle --style=kr --indent=spaces=4 --suffix=none *.c *.h


clean:
	$(RM) $(TESTS) $(OBJS)
	$(RM) $(deps)
	$(RM) gen_cmd
	$(RM) gen_freq

-include $(deps)
