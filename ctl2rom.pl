#!/usr/bin/perl

use Data::Dumper;
use strict;

my $addr = 0;

{
  my $junk = <>;
  $junk = <>;
}

print "v2.0 raw\n";

LINE:
while (<>)
{
  chomp;
  s/^\s+//;
  s/\s+$//;

  my $val = 0;

  my @stuff = split(/\s+/, $_);

  print Dumper(\@stuff);
  exit;

  my ($d, $h, $b, $op,
    $aluop, $jump, $branch, $regdst, $regwr, $extop, $memwr, $mem2reg, $alusrc,
    $junk) = @stuff;

  $val &= 1 << 0 if $jump eq '1';

  next LINE unless ($word);

  $loc = eval('0x' . $loc);

  my $i = 0;

  while ($addr < $loc)
  {
    $i++;
    $addr += 4;
  }

  printf "%s*0\n", $i if $i;

  printf "%s\n", $word;

  $addr += 4;
}

__END__

De He Bin    Opcode    ALUop jump branch RegDst RegWr ExtOp MemWr Mem2Reg ALUsrc
De He Bin    Opcode    ALUop  J  B RD RW EO MW MR AS
 0 00 000000 Funct(1)  .      .  .  .  .  .  .  .  .
 1 01 000001 .         .      .  .  .  .  .  .  .  .
 2 02 000010 j         .      1  .  .  .  .  .  .  .
 3 03 000011 jal       .      1  .  .  .  .  .  .  .
 4 04 000100 beq       .      .  1  .  .  .  .  .  .
 5 05 000101 bne       .      .  1  .  .  .  .  .  .
 6 06 000110 blez      .      .  1  .  .  .  .  .  .
 7 07 000111 bgtz      .      .  1  .  .  .  .  .  .
