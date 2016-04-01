
# PATH := /usr/local/mips/bin:$PATH

CC := mips-linux-gnu-gcc -msoft-float
AS := mips-linux-gnu-as -msoft-float
LD := mips-linux-gnu-ld
OBJDUMP := mips-linux-gnu-objdump

%.objdump: %
	${OBJDUMP} -d $< > $@

%.objdump: %.o
	${OBJDUMP} -d $< > $@

%.rom: %.objdump parse_objdump.pl
	./parse_objdump.pl $< > $@

%: %.o
	mips-linux-gnu-ld -o $@ $<

%.rom: %.ctl
	./ctl2rom.pl $< > $@

