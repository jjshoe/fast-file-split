#!/usr/bin/perl

use strict;
use warnings;

my $string;
my $counter = 1;

open(my $in_fh, '<', 'combined.out');
open(my $out_fh, '>', 'split' . $counter . '.csv');

while (my $line = <$in_fh>)
{
	$string .= $line;
	{
		use bytes;

		if (length($string) >= (1024 * 1024 * 95))
		{
			$counter++;
			print $out_fh $string;
			close($out_fh);

			$string = '';
			open($out_fh, '>', 'split' . $counter . '.csv');
		}
	}
}

print $out_fh $string;
close($out_fh);
