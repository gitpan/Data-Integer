use Test::More tests => 10;

BEGIN { use_ok "Data::Integer", qw(
	natint_bits min_natint max_natint
	min_signed_natint max_signed_natint
	min_unsigned_natint max_unsigned_natint
); }

ok int(natint_bits) == natint_bits;
ok natint_bits >= 16;

use integer;

my $a = -1;
for(my $i = natint_bits-1; $i--; ) { $a += $a; }
is $a, min_signed_natint;
is $a, min_natint;

is min_signed_natint + max_signed_natint, -1;

no integer;

is min_unsigned_natint, 0;

my $b = 1;
my $c = 1;
for(my $i = natint_bits-1; $i--; ) { $b += $b; $c += $b; }
is $b - 1, max_signed_natint;
is $c, max_unsigned_natint;
is $c, max_natint;
