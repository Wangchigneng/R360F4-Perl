#!/usr/bin/perl -w
$AddFlag=0;
open FILE, "<startup.nsh" or die "open file for read ERROR!";
my @temp = <FILE>;
close (FILE);
open FILE, ">startup.nsh" or die "open file for write ERROR!";
foreach my $data (@temp) {
	$data =~ s|pause|#//VW pause|g;
    if($data =~ /:BMC/) {
        print FILE $data;	
        print FILE "#//VW\n";
		print FILE '@echo ';
		print FILE '"Acer Smart console is being updated"'."\n";
        print FILE "fwpiaupd.efi -ni -u -pia Acer_F4_EWS.bin\n";		
        print FILE "#//VW\n";		
    } elsif ($data =~ /stall 6000000/) {	
        print FILE $data;	
		if ($AddFlag==0) {
			print FILE "#//VW\n";
			print FILE '@echo ';
			print FILE '"Update LAN MAC address into FRU Extra Field"'."\n";
			print FILE "frumac.nsh\n";
			print FILE '@echo ';
			print FILE '"Enable BMC user ID 2 -- Channel 1"'."\n";
			print FILE "syscfg.efi /ue 2 enable 1\n";
			print FILE '@echo ';
			print FILE '"Set user ID 2 name and password"'."\n";	
			print FILE "syscfg.efi /u 2 root superuser\n";
			print FILE '@echo ';
			print FILE '"Set BMC user ID 2 -- channel 1 Admin priviledge"'."\n";
			print FILE "syscfg.efi /up 2 1 admin\n";
			print FILE '@echo ';
			print FILE '"Enable BMC user ID 2 -- channel 3"'."\n";
			print FILE "syscfg.efi /ue 2 enable 3\n";
			print FILE '@echo ';
			print FILE '"Set BMC user ID 2 -- channel 3 Admin priviledge"'."\n";
			print FILE "syscfg.efi /up 2 3 admin\n";		
		#    print FILE "#//VW\n";	
		#} elsif ($data =~ /:END/) {	
		#    print FILE $data;	
		#    print FILE "#//VW\n";
			print FILE '@echo ';
			print FILE '"============================================================"'."\n";		
			print FILE "short.nsh\n";						
			print FILE "frusdr.efi -d fru\n";	
			print FILE "#//VW\n";
			$AddFlag=1;
		}
	} elsif ($data =~ /echo 1 >> reset.log/ ) {
		print FILE $data;	
		print FILE '						echo " "'."\n";
		print FILE '						echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"'."\n";
		print FILE '						echo "! The update procedure is not completed, You need to run      !"'."\n";
		print FILE '						echo "! Startup.nsh again after reboot.                             !"'."\n";
		print FILE '						echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"'."\n";
		print FILE '						echo " "'."\n";
		print FILE '						echo "press Space key or Enter Key to reboot!"'."\n";
		print FILE '						pause -q'."\n";		
	#} elsif ($data =~ /reset -c/) {
	#    print FILE "#//VW ";
	#	print FILE $data;
	} else {
        print FILE $data;
	}
}
close (FILE);