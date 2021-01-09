#!/usr/bin/perl -w
use Cwd;
my $Current_Dir = getcwd;
print $Current_Dir,"\n";
#$Directory_Str="/";
$Release_Directory_Str="/ReleaseNote";
if (-e $ARGV[3])
{
print $ARGV[3]," exist.\n";
}
else
{
print $ARGV[3]," not exist. Directory Created!\n";
mkdir( $ARGV[3] ) or die "can not create ".$ARGV[3]." directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3] ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]." directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3] ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]." directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3].$Release_Directory_Str ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3].$Release_Directory_Str." directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10" ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"." directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/DOC" ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/DOC directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/EWS_Unlocker" ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/EWS_Unlocker directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10" ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10"." directory!\n";
mkdir( $ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10".$Release_Directory_Str ) or die "can not create ".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10".$Release_Directory_Str." directory!\n";
print $ARGV[3]." directory create successfully\n";
}
print "ARGV[0]:".$ARGV[0]."\n";
print "ARGV[2]:".$ARGV[2]."\n";
if ( (-e $ARGV[0]) && (-e $ARGV[2]) )
{
$org_source = $Current_Dir."/".$ARGV[0];
$add_source = $Current_Dir."/".$ARGV[2]."/".$ARGV[1]."_".$ARGV[2]."_L10"."/".$ARGV[1]."_".$ARGV[2]."_L10";
$ews_source=$Current_Dir."/".$ARGV[2]."/".$ARGV[1]."_".$ARGV[2]."_L10"."/EWS_Unlocker";
$doc_source=$Current_Dir."/".$ARGV[2]."/".$ARGV[1]."_".$ARGV[2]."_L10"."/DOC";
$target_user = $Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3];
$target_L10 = $Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10";
$ews_target=$Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/EWS_Unlocker";
$doc_target=$Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/DOC";
print "org_source:".$org_source."\n";
print "add_source:".$add_source."\n";
print "target_L10:".$target_L10."\n";
}
else
{
print "org_source:".$org_source."\n";
print "add_source:".$add_source."\n";
print "target_L10:".$target_L10."\n";
  print "No Source Directory!Exit!\n";
  return;
}

&copy_to_acerdir($org_source,$target_user);
&copy_AddtionalFiles($add_source,$target_user);
&copy_to_acerdirL10($org_source,$target_L10);
&copy_to_ewsdirL10($ews_source,$ews_target);
&copy_to_docdirL10($doc_source,$doc_target);
&copy_AddtionalFilesL10($add_source,$target_L10);
&move_TXTFiles();
&move_TXTFilesL10();

sub copy_to_acerdir{
  use File::Copy;
  opendir(DIR,$org_source);
  print "org_source:",$org_source,"\n";
  print "target_user:",$target_user,"\n"; 
  my $pdffilter=".pdf";    
  while(my $filename = readdir(DIR)){
    if((-f "$org_source/$filename") && (not ($filename =~ /$pdffilter$/))){
      copy("$org_source/$filename","$target_user/$filename") or die "can't copy: $!\n";
    }
  }
  close(DIR);
}
sub copy_AddtionalFiles{
  use File::Copy;
  opendir(ADDSOURCEDIR,$add_source);
  opendir(TARGETDIR,$target_user); 
  #$file9="master.cfg";     
  #$file11="master_fru.cfg";          
  #$file12="master_sdr.cfg"; 
  $file13="flashupdt.cfg";              
  #copy($target_user."/".$file9,$target_user."/".$file11) or die "can't copy: $file11!\n";    
  #copy($target_user."/".$file9,$target_user."/".$file12) or die "can't copy: $file12!\n";      
  copy($add_source."/".$file13,$target_user."/".$file13) or die "can't copy: $file13!\n";        
  close(ADDSOURCEDIR);
  close(TARGETDIR);  
}
sub copy_to_acerdirL10{
  use File::Copy;
  opendir(DIR,$org_source);
  print "org_source2:",$org_source,"\n";
  print "target_L10:",$target_L10,"\n"; 
  my $pdffilter=".pdf";  
  while(my $filename = readdir(DIR)){
    if((-f "$org_source/$filename") && (not ($filename =~ /$pdffilter$/))){
      copy("$org_source/$filename","$target_L10/$filename") or die "can't copy: $!\n";
    }
  }
  close(DIR);
}
sub copy_to_ewsdirL10{
  use File::Copy;
  opendir(DIR,$ews_source);
  print "ews_source:",$ews_source,"\n";
  print "ews_target:",$ews_target,"\n"; 
  while(my $filename = readdir(DIR)){
    if((-f "$ews_source/$filename")){  
      copy("$ews_source/$filename","$ews_target/$filename") or die "ews can't copy: $!\n";
	}
  }
  close(DIR);
}
sub copy_to_docdirL10{
  use File::Copy;
  opendir(DIR,$doc_source);
  print "ews_source:",$doc_source,"\n";
  print "ews_target:",$doc_target,"\n"; 
  while(my $filename = readdir(DIR)){
    if((-f "$doc_source/$filename")){  
      copy("$doc_source/$filename","$doc_target/$filename") or die "ews can't copy: $!\n";
	}
  }
  close(DIR);
}
sub copy_AddtionalFilesL10{
  use File::Copy;
  opendir(ADDSOURCEDIR,$add_source);
  opendir(TARGETDIR,$target_L10); 
  $file1="Acer_EWS.nsh";  
  $file2="Acer_F4_EWS.bin";  
  $file3="cmdtool.efi";  
  $file4="cmdtool_temp.efi";  
  $file5="eeupdate64e.efi";  
  $file6="frumac.nsh";  
  $file7="MACRW.efi";    
  $file8="NShell.efi";      
  $file9="master.cfg";        
  $file10="macmaster.cfg";          
  $file11="syscfg.efi";            
  $file12="syscfg_temp.efi";            
  $file13="flashupdt.cfg";   
  $file14="Acer_F4_EWS.bin"; 
  #$file11="master_fru.cfg";          
  #$file12="master_sdr.cfg";            
  copy("$add_source/$file1","$target_L10/$file1") or die "can't copy: $file1!\n";
  copy("$add_source/$file2","$target_L10/$file2") or die "can't copy: $file2!\n";
  copy("$add_source/$file3","$target_L10/$file3") or die "can't copy: $file3!\n";
  copy("$add_source/$file4","$target_L10/$file4") or die "can't copy: $file4!\n";
  copy("$add_source/$file5","$target_L10/$file5") or die "can't copy: $file5!\n";
  copy("$add_source/$file6","$target_L10/$file6") or die "can't copy: $file6!\n";
  copy("$add_source/$file7","$target_L10/$file7") or die "can't copy: $file7!\n";
  copy("$add_source/$file8","$target_L10/$file8") or die "can't copy: $file8!\n";  
  copy("$target_L10/$file9","$target_L10/$file10") or die "can't copy L10: $file10!\n";    
  copy("$add_source/$file11","$target_L10/$file11") or die "can't copy L10: $file11!\n";    
  copy("$add_source/$file12","$target_L10/$file12") or die "can't copy L10: $file12!\n";      
  copy("$add_source/$file13","$target_L10/$file13") or die "can't copy L10: $file13!\n";        
  copy("$add_source/$file14","$target_L10/$file14") or die "can't copy L10: $file14!\n";          
  close(ADDSOURCEDIR);
  close(TARGETDIR);  
}
sub move_TXTFiles{
  use File::Copy;
  my $old_loc = $Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/";
  my $release_dir = $Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3].$Release_Directory_Str."/";
  my $filterstring = ".txt";  
  my $keepfilename="Common Questions.txt";  
  
  opendir(ADDSOURCEDIR,$Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]);
  opendir(TARGETDIR,$Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3].$Release_Directory_Str); 

  foreach  my $filename (readdir(ADDSOURCEDIR)) {
    next if not $filename =~ /$filterstring$/;
    my $old_file = $old_loc . $filename;
	my $new_file = $release_dir . $filename;	
    print "Moving $old_file to $new_file\n";
    move($old_file, $new_file);
	if (not $new_file =~ /$keepfilename$/){
	    unlink $new_file if -e $new_file;
		print "del file: $new_file\n";  		
	}
  }
  close(ADDSOURCEDIR);
  close(TARGETDIR);  
}
sub move_TXTFilesL10{
  use File::Copy;
  my $old_loc = $Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10/";
  my $release_dir = $Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10/".$Release_Directory_Str."/";
  my $filterstring = ".txt";  
  
  opendir(ADDSOURCEDIR,$Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10");
  opendir(TARGETDIR,$Current_Dir."/".$ARGV[3]."/".$ARGV[1]."_".$ARGV[3]."_L10"."/".$ARGV[1]."_".$ARGV[3]."_L10".$Release_Directory_Str); 

  foreach  my $filename (readdir(ADDSOURCEDIR)) {
    next if not $filename =~ /$filterstring$/;
    my $old_file = $old_loc . $filename;
	my $new_file = $release_dir . $filename;	
    print "Moving $old_file to $new_file\n";
    move($old_file, $new_file);
  }    
  close(ADDSOURCEDIR);
  close(TARGETDIR);  
}