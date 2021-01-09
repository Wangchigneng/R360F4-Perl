#!/usr/bin/perl -w
$MENUPROMPT_NextFlag=0;
$ChassisFruFlag=0;
$ChassisField1Flag=0;
$ChassisField2Flag=0;
$UPD_CHS_Flag=0;
$ProductFruFlag=0;
$MarkCount=0;
$UPD_CHS_Count=0;
open FILE, "<macmaster.cfg" or die "open file for read ERROR!";
my @temp = <FILE>;
close (FILE);
open FILE, ">macmaster.cfg" or die "open file for write ERROR!";
foreach my $data (@temp) {
    if($data =~ m/MENUTITLE    "Select the function you want to perform:"/) {
		$data =~ s{MENUTITLE    "Select the function you want to perform:"}{//VW MENUTITLE    "Select the function you want to perform:"}g; 
        print FILE $data;				
	} elsif($data =~ m#MENU        "SDR"    "Update only the SDR"#) {
		$data =~ s{MENU        "SDR"    "Update only the SDR"}{//VW MENU        "SDR"    "Update only the SDR"}g; 
        print FILE $data;		
	} elsif($data =~ m#MENU        "FRU"    "Update only the FRU"#) {
		$data =~ s{MENU        "FRU"    "Update only the FRU"}{//VW MENU        "FRU"    "Update only the FRU"}g; 
        print FILE $data;		
	} elsif($data =~ m#MENU        "BOTH"    "Update both the SDR and the FRU"#) {
		$data =~ s{MENU        "BOTH"    "Update both the SDR and the FRU"}{//VW MENU        "BOTH"    "Update both the SDR and the FRU"}g; 
        print FILE $data;		
	} elsif($data =~ m#MENU        "ASSET"    "Modify the Asset Tag"#) {
		$data =~ s{MENU        "ASSET"    "Modify the Asset Tag"}{//VW MENU        "ASSET"    "Modify the Asset Tag"}g; 
        print FILE $data;		
	} elsif ($data =~ m#MENU        "EXIT1"    "Exit FRU/SDR update"#) {
		$data =~ s{MENU        "EXIT1"    "Exit FRU/SDR update"}{//VW MENU        "EXIT1"    "Exit FRU/SDR update"}g; 
        print FILE $data;		
		$MENUPROMPT_NextFlag=1;
	} elsif(($data =~ m/MENUPROMPT/) &&($MENUPROMPT_NextFlag == 1)){
		$data =~ s{MENUPROMPT}{//VW MENUPROMPT}g; 
		print FILE $data;				
		print FILE '	SET "FRU"		// vv'."\n";
		$MENUPROMPT_NextFlag=0;
	} elsif($data =~ /Do you want to update the chassis info area of the FRU/) {
	    print "!!!!!!!!!!!!!!!!!!!!!!!!Update FRU!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
		print FILE "//VW".$data;
		$ChassisFruFlag=1;
		$MarkCount++;
	} elsif($data =~ /Do you want to enter data into the additional chassis field 1/) {
		print FILE "//VW".$data;
		$ChassisField1Flag=1;
		$MarkCount++;
	} elsif($data =~ /Do you want to enter data into the additional chassis field 2/){
		print FILE "//VW".$data;
		$ChassisField2Flag=1;
		$MarkCount++;			
	} elsif($data =~ /Do you want to update the product info area of the FRU/){
		print FILE "//VW".$data;
		$ProductFruFlag=1;
		$MarkCount++;		
	} elsif($data =~ /IFSET "UPD_CHS"/){
		print FILE $data;		
		$UPD_CHS_Flag=1;
		$UPD_CHS_Count++;		
	} elsif (($UPD_CHS_Count >= 2)&&($UPD_CHS_Count <= 20)) {
		print FILE "//VW ".$data;		
		$UPD_CHS_Count++;
		if ($UPD_CHS_Count > 20) {
			$UPD_CHS_Flag=0;
		}
	} elsif (($MarkCount>=1)&&($MarkCount<=2)){
		print FILE "//VW ".$data;
		if (($MarkCount==2) &&($ChassisFruFlag==1)){
			print FILE 'SET "UPD_CHS" //VW'."\n";
			$ChassisFruFlag=0;
			$MarkCount=-1;
		}
		if (($MarkCount==2) &&($ChassisField1Flag==1)){
			print FILE 'SET "CHASS_INFO_1" //VW'."\n";
			$ChassisField1Flag=0;
			$MarkCount=-1;
		}
		if (($MarkCount==2) &&($ChassisField2Flag==1)){
			print FILE 'SET "CHASS_INFO_2" //VW'."\n";
			$ChassisField2Flag=0;
			$MarkCount=-1;
		}				
		if (($MarkCount==2) && ($ProductFruFlag==1)) {
			print FILE '            FRUFIELD    "MN" "Acer"             // VW'."\n";
			print FILE '	        IFSET "S2600WFT"  // VW'."\n";
			print FILE '				FRUFIELD    "PN" "Altos R360 F4" // VW'."\n";
			print FILE '            ELSE  // VW'."\n";
			print FILE '               	IFSET "S2600WFQ"  // VW'."\n";
			print FILE '              		FRUFIELD    "PN" "Altos R360 F4" // VW'."\n";
			print FILE '               	ELSE   // VW'."\n";
#			print FILE '               		IFSET "S2600BPP" // VW'."\n";
#			print FILE '               			FRUFIELD    "PN" "Altos R360 F4" // VW'."\n";
#			print FILE '               		ELSE  // VW'."\n";
			print FILE '               			IFSET "S2600WF0"              // VW'."\n";
			print FILE '               				FRUFIELD    "PN" "Altos R360 F4" // VW'."\n";			
			print FILE '						ELSE	//VW'."\n";			
			print FILE '							IFSET "S26000WFS"              // VW'."\n";			
			print FILE '								FRUFIELD    "PN" "Altos R360 F4" // VW'."\n";			
			print FILE '							ELSE  // VW'."\n";			
			print FILE '								FRUFIELD    "PN" "Altos R360 F4" // VW'."\n";			
			print FILE '							ENDIF  // VW'."\n";			
			print FILE '						ENDIF  // VW'."\n";			
			print FILE '					ENDIF  // VW'."\n";			
			print FILE '				ENDIF  // VW'."\n";			
#			print FILE '			ENDIF  // VW'."\n";			
			print FILE '            FRUFIELD    "PV"                    // VW'."\n";
			print FILE '            DISPLAY      " "                    // VW'."\n";						
			$MarkCount=-1;		
		}
		$MarkCount++;
	}
	else{
		print FILE $data;
		if($UPD_CHS_Flag==1) {
			$UPD_CHS_Count++; 
		}
	}	
}
close (FILE);