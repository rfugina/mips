
# PATH := /usr/local/mips/bin:$PATH

CC := mips-linux-gnu-gcc
AS := mips-linux-gnu-as
LD := mips-linux-gnu-ld
OBJDUMP := mips-linux-gnu-objdump

%.objdump: %.o
	$OBJDUMP -d $< > $@

%.rom: %.objdump parse_objdump.pl
	./parse_objdump.pl $< > $@

%: %.o
	mips-linux-gnu-ld -o $@ $<

%.rom: %.ctl
	./ctl2rom.pl $< > @$

