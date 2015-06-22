
# PATH := /usr/local/mips/bin:$PATH

AS := mips-as
LD := mips-ld

%.rom: %.o parse_objdump.pl
	mips-objdump -d $< | ./parse_objdump.pl > $@

%: %.o
	mips-ld -o $@ $<

