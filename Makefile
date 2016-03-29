
# PATH := /usr/local/mips/bin:$PATH

CC := mips-linux-gnu-gcc
AS := mips-linux-gnu-as
LD := mips-linux-gnu-ld

#%.rom: %.o parse_objdump.pl
#	mips-linux-gnu-objdump -d $< | ./parse_objdump.pl > $@

%.objdump: %.o
	mips-linux-gnu-objdump -d $< > $@

%.rom: %.objdump parse_objdump.pl
	./parse_objdump.pl $< > $@

%: %.o
	mips-linux-gnu-ld -o $@ $<

%.rom: %.ctl
	./ctl2rom.pl $< > @$

