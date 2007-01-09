=head1 NAME

Data::Integer - details of the native integer data type

=head1 SYNOPSIS

	use Data::Integer qw(max_natint);

	$n = max_natint;

	# and other constants; see text

=head1 DESCRIPTION

This module is about the native integer numerical data type.  A native
integer is one of the types of datum that can appear in the numeric part
of a Perl scalar.  This module supplies constants describing the native
integer type.

There are actually two native integer representations: signed and
unsigned.  Both are handled by this module.

=cut

package Data::Integer;

use warnings;
use strict;

our $VERSION = "0.000";

use base "Exporter";
our @EXPORT_OK = qw(
	natint_bits min_natint max_natint
	min_signed_natint max_signed_natint
	min_unsigned_natint max_unsigned_natint
);

=head1 CONSTANTS

=over

=item natint_bits

The width, in bits, of the native integer data type.

=item min_natint

The minimum representable value.  This is -2^(natint_bits - 1).

=item max_natint

The maximum representable value.  This is 2^natint_bits - 1.

=item min_signed_natint

The minimum representable value in the signed representation.  This is
-2^(natint_bits - 1).

=item max_signed_natint

The maximum representable value in the signed representation.  This is
2^(natint_bits - 1) - 1.

=item min_unsigned_natint

The minimum representable value in the unsigned representation.
This is zero.

=item max_unsigned_natint

The maximum representable value in the unsigned representation.  This is
2^natint_bits - 1.

=back

=cut

# Count the number of bits in native integers by repeatedly shifting a bit
# left until it turns into the sign bit.  "use integer" forces the use of a
# signed integer representation.
{
	use integer;
	my $natint_bits = 1;
	my $min_signed_natint = 1;
	while($min_signed_natint > 0) {
		$natint_bits++;
		$min_signed_natint <<= 1;
	}
	*natint_bits = sub () { $natint_bits };
	*min_signed_natint = sub () { $min_signed_natint };
}

# The rest of the code is parsed after the constants above have been
# calculated and installed, so that it can benefit from their constancy.
eval do { local $/; <DATA>; } or die $@;
__DATA__
local $SIG{__DIE__};

use constant max_signed_natint => -(min_signed_natint + 1);
use constant min_unsigned_natint => 0;
use constant max_unsigned_natint => max_signed_natint + max_signed_natint + 1;

*min_natint = \&min_signed_natint;
*max_natint = \&max_unsigned_natint;

=head1 AUTHOR

Andrew Main (Zefram) <zefram@fysh.org>

=head1 COPYRIGHT

Copyright (C) 2007 Andrew Main (Zefram) <zefram@fysh.org>

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
