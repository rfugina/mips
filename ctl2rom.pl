#!/usr/bin/perl

use Data::Dumper;
use strict;

my $aluops = {
  '.'  => '000000',
  and  => '000000',
  or   => '000001',
  xor  => '000010',
  add  => '000011',
  sub  => '000100',
  sll  => '000101',
  srl  => '000110',
  sra  => '000111',
  mult => '001000',
  div  => '001001',
  neg  => '001010',
  nor  => '001011',
  };

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

  my ($d, $h, $b, $op,
    $aluop, $jump, $branch, $regdst, $regwr, $extop, $memwr, $mem2reg, $alusrc,
    $done, $junk) = @stuff;

  #print Dumper(\@stuff);

  die unless exists $aluops->{$aluop};

  my $str = '0000000000000000';

  # right of string is least significant digit...
  substr($str, 15, 1) = '1' if $regdst == '1';
  substr($str, 14, 1) = '1' if $regwr == '1';
  substr($str, 13, 1) = '1' if $extop == '1';
  substr($str, 12, 1) = '1' if $memwr == '1';
  substr($str, 11, 1) = '1' if $mem2reg == '1';
  substr($str, 10, 1) = '1' if $alusrc == '1';
  substr($str, 9, 1) = '1' if $branch == '1';
  substr($str, 8, 1) = '1' if $jump == '1';

  substr($str, 2, 6) = substr('000000' . $aluops->{$aluop}, -6, 6); # left pad with zeros, keep 6 digits

  #substr($str, 1, 1) = '1' if $extop == '1';
  substr($str, 0, 1) = '1' if $done == '1';

  my $val = eval('0b' . $str);

  printf "%04x\n", $val;
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
