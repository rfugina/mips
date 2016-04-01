#!/usr/bin/perl

use Data::Dumper;
use strict;

my $addr = 0;

print "v2.0 raw\n";

LINE:
while (<>)
{
	chomp;
	my ($loc, $word, $instr) = /^\s*([\da-f]+):\s+([\da-f]{8})\s+(.*)$/i;

	next LINE unless ($word);

	$loc = eval('0x' . $loc);

	my $i = 0;

	while ($addr < $loc)
	{
		$i++;
		$addr += 4;
	}

	printf "%s*0\n", $i if $i;

	# printf STDERR "%s\n", $instr;
	printf "%s\n", $word;

	$addr += 4;
}


__END__


myprog.o:     file format elf32-bigmips


Disassembly of section .text:

00000000 <init-0x10>:
   0:	20020004 	addi	v0,zero,4
   4:	344200f1 	ori	v0,v0,0xf1
   8:	08000004 	j	10 <init>
   c:	3042000f 	andi	v0,v0,0xf

00000010 <init>:
  10:	10000010 	b	54 <error+0x10>
  14:	00000825 	move	at,zero

00000018 <loop>:
  18:	20210001 	addi	at,at,1
  1c:	1422fffe 	bne	at,v0,18 <loop>
  20:	00000000 	nop
  24:	8c030000 	lw	v1,0(zero)
  28:	00000000 	nop
  2c:	00611820 	add	v1,v1,at
  30:	ac030000 	sw	v1,0(zero)
  34:	00000820 	add	at,zero,zero
  38:	34030018 	li	v1,0x18
  3c:	00600008 	jr	v1
  40:	00000000 	nop

00000044 <error>:
  44:	00000000 	nop
