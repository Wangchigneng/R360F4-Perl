#!/usr/bin/perl -w
open FILE, "<startup.nsh" or die "open file for read ERROR!";
my @temp = <FILE>;
close (FILE);
open FILE, ">startup.nsh" or die "open file for write ERROR!";
foreach my $data (@temp) {
	$data =~ s|pause|#//VW pause|g;

	if ($data =~ /echo 1 >> reset.log/ ) {
		print FILE $data;	
		print FILE '						echo " "'."\n";
		print FILE '						echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"'."\n";
		print FILE '						echo "! The update procedure is not completed, You need to run      !"'."\n";
		print FILE '						echo "! Startup.nsh again after reboot.                             !"'."\n";
		print FILE '						echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"'."\n";
		print FILE '						echo " "'."\n";
		print FILE '						echo "press Space key or Enter Key to reboot!"'."\n";
		print FILE '						pause -q'."\n";		
	} else {
        print FILE $data;
	}
	
}
close (FILE);