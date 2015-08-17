#!/usr/bin/perl
use Encode;
use utf8;

#swara: C85, C86, C87, C88, C89, C8A, C8B, CE0, C8C, C8E, C8F, C90, C92, C93, C94,
#     : a     A    i    I   u     U    Qu   QU  Null  e    E    ai   o    O    au
#anuswara:  C82: M
#visarga:   C83: H
$swara = "C85|C86|C87|C88|C89|C8A|C8B|CE0|C8E|C8F|C90|C92|C93|C94|CBD";
%swara_a=(
"C85"=>"a",
"C86"=>"A",
"C87"=>"i",
"C88"=>"I",
"C89"=>"u",
"C8A"=>"U",
"C8B"=>"Qu",
"CE0"=>"QU",
"C8E"=>"e",
"C8F"=>"E",
"C90"=>"ai",
"C92"=>"o",
"C93"=>"O",
"C94"=>"au",
"CBD"=>"\\s ",
);

#Vargiya Vyanjana
#vyanjana: C95, C96, C97, C98, C99: ka Ka  ga Ga  kna
#		   C9A, C9B, C9C, C9D, C9E: ca Ca  ja Ja  cna
#          C9F, CA0, CA1, CA2, CA3: Ta Tha Da Dha Na
#          CA4, CA5, CA6, CA7, CA8: ta tha da dha na
#          CAA, CAB, CAC, CAD, CAE: pa Pa  ba Ba  ma
#avargiya Vyanjana
#CAF, CB0, CB1, CB2, CB5, CB6, CB7, CB8, CB9, CB3, CDE,
#ya   ra   273   la   va  sha   Sa   sa   ha   La  274
$vyanjana = "C95|C96|C97|C98|C99|C9A|C9B|C9C|C9D|C9E|C9F|CA0|CA1|CA2|CA3|CA4|CA5|CA6|CA7|CA8|CAA|CAB|CAC|CAD|CAE|CAF|CB0|CB1|CB2|CB5|CB6|CB7|CB8|CB9|CB3|CDE";
$vy_kan = "k|K|g|G|kn|c|C|j|J|cn|T|Th|D|Dh|N|t|th|d|dh|n|p|P|b|B|m|y|r|l|v|S|sh|s|h|L";
%vyanjana_a = (
"C95"=>"k",
"C96"=>"K",
"C97"=>"g",
"C98"=>"G",
"C99"=>"kn",
"C9A"=>"c",
"C9B"=>"C",
"C9C"=>"j",
"C9D"=>"J",
"C9E"=>"cn",
"C9F"=>"T",
"CA0"=>"Th",
"CA1"=>"D",
"CA2"=>"Dh",
"CA3"=>"N",
"CA4"=>"t",
"CA5"=>"th",
"CA6"=>"d",
"CA7"=>"dh",
"CA8"=>"n",
"CAA"=>"p",
"CAB"=>"P",
"CAC"=>"b",
"CAD"=>"B",
"CAE"=>"m",
"CAF"=>"y",
"CB0"=>"r",
"CB1"=>"6",
"CB2"=>"l",
"CB5"=>"v",
"CB6"=>"sh",
"CB7"=>"S",
"CB8"=>"s",
"CB9"=>"h",
"CB3"=>"L",
"CDE"=>"7");

#Symbols
#CBC, CBD, CBE, CBF, CC0, CC1, CC2, CC3, CC4, CC6, CC7, CC8, CCA, CCB, CCC,
#      \S   A    i    iV   u    U    q    qq   e    eV   eY   o    oV   w
$symbols="CBC|CBE|CBF|CC0|CC1|CC2|CC3|CC4|CC6|CC7|CC8|CCA|CCB|CCC";
%symbols_a = (
"CBE"=>"A",
"CBF"=>"i",
"CC0"=>"iV",
"CC1"=>"u",
"CC2"=>"U",
"CC3"=>"q",
"CC4"=>"qq",
"CC6"=>"e",
"CC7"=>"eV",
"CC8"=>"eY",
"CCA"=>"o",
"CCB"=>"oV",
"CCC"=>"w"
);

#Halanta
#CCD: f

#Numbers
#CE6, CE7, CE8, CE9, CEA, CEB, CEC, CED, CEE, CEF
# 0    1    2    3    4    5    6    7    8    9
$numbers = "CE6|CE7|CE8|CE9|CEA|CEB|CEC|CED|CEE|CEF";
%numbers_a=(
"CE6"=>"0",
"CE7"=>"1",
"CE8"=>"2",
"CE9"=>"3",
"CEA"=>"4",
"CEB"=>"5",
"CEC"=>"6",
"CED"=>"7",
"CEE"=>"8",
"CEF"=>"9"
);

#Others
#CD5, CD6, CE1, CE2, CE3, CF1, CF2,
#          274

$vowel_endings = "ಾ|ಿ|ೀ|ು|ೂ|ೃ|ೄ|ೆ|ೇ|ೈ|ೊ|ೋ|ೌ|್|ೕ|ೖ";
$rf = "ರ್";
$vyn = "ಕ|ಖ|ಗ|ಘ|ಙ|ಚ|ಛ|ಜ|ಝ|ಞ|ಟ|ಠ|ಡ|ಢ|ಣ|ತ|ಥ|ದ|ಧ|ನ|ಪ|ಫ|ಬ|ಭ|ಮ|ಯ|ಱ|ಲ|ಳ|ವ|ಶ|ಷ|ಸ|ಹ|ೞ";

#$str = "ಅಕ್ಕ ಲಕ್ಷ್ಮೀಷ ನೀಲ್ ಆರ್ಮ್‌ಸ್ಟ್ರಾಂಗ್ ಸೂರ್ಯ ಮರ್ಯಾದೆ ಧೀರ್ಘ ದುರ್ಯೋಧನ ಸರ್ವರ್ ವಾರ್ಧಿಕ್ಯಸರ್ರನೆ\n";
#$str = "ನೀವೂ ಆಚರಣೆಯಲ್ಲಿ ಭಾಗವಹಿಸಬಹುದು. ಸಣ್ಣದೊಂದು ಕಾರ್ಯಾಗಾರವನ್ನು ನೀವು ಇರುವೆಡೆಯಲ್ಲಿಯೇ ಕೆಲವೇ ನಿಮಿಷಗಳಲ್ಲಿ ಆಯೋಜಿಸಬಹುದು. ತಂತ್ರಜ್ಞಾನ\n";
#$str = "ಲಕ್ಷ್ಮೀಷ";
#$str = "ಭಾರತದ ರಾಷ್ಟ್ರಪತಿಗಳು ವಿಕಿ ಸೋರ್ಸ್\n";
#$str = "ಸೂರ್ಯ";
#$str = "ಪ್ರಯತ್ನದೊಳು";
#$str = "ಪ್ರವೃತ್ತಿ";
#$str = "ಕಾರ್ಯೋನ್ಮುಖ";
#$str = "ಅಂಕಣ";
#$str = "ವಿಜ್ಞಾನ";
#$str = "ಸಂಧರ್ಬದೊಳು";
#$str = "ರಾಜಕುಮಾರ್";
#$str = "ವಿಕಿಪೀಡಿಯನ್ನರೆ";
#$str = "ವಿಶ್ವನಾಥನ್ ಆನಂದ್";
#$str = "ಪ್ರಯೋಗಾರ್ಥ";
#$str = "ಪುರಸ್ಕೃತರು";
#$str = "ಆಸ್ಟ್ರಿಯ";
#$str = "ಕ್ರೈಸ್ತ ಧರ್ಮ";
#$str = "ಸ್ವಾತಂತ್ರ್ಯ";
#$str = "ನೀಲ್ ಆರ್ಮ್‌ಸ್ಟ್ರಾಂಗ್";

$infile = "bvartika_uni.tex";
$outfile = "bvartika.tex";

open(IN,"<:encoding(UTF-8)","$infile") or die "Can't open $infile\n";
open(OUT,">$outfile") or die "Can't open $outfile\n";

$line = <IN>;

#declaring flags
$vflag = 0;
$sym_flag = 0;
$hl_count = 0;
$prev = 0;
$uni_string = "";
$kantex = "";

while($line)
{
#	chop($line);

	$line =~ s/<br \/>/\\\\\n/g;
	$line =~ s/($vyn)($rf)($vowel_endings)/\2\1\3/g;
	@list = split(//,$line);

$vflag = 0;
$sym_flag = 0;
$hl_count = 0;
$prev = 0;
$uni_string = "";
$kantex = "";

for($i=0;$i<@list; $i++)
{
	$hex = DecToNumBase(ord($list[$i]), 16);
	$decimal = ord($list[$i]);
	#print $hex . "\n";

	if( ($decimal >= 3202) && ($decimal <= 3314) )
	{
		Convert_to_TeX($hex);	
	}
	else
	{
		if( ($hex == "200C") && ($prev == 0) )
		{
			
		}
		if( ($hex == "200C") && ($prev == 4) )
		{
			$kantex =~ s/a/f/;
			$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;			
			$kantex =~ s/R($vy_kan)X/\1xR/;
			$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
			$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
			$kantex =~ s/V($vy_kan)x/\1xV/g;
			print OUT $kantex;
			$prev = 0;
			#print $hex . "\n";
			$kantex = "";
			$vflag = 0;
			$hl_count = 0;		
		}
		elsif($prev == 4)
		{
			$kantex =~ s/a/f/;
			$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;			
			$kantex =~ s/R($vy_kan)X/\1xR/;
			$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
			$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
			$kantex =~ s/V($vy_kan)x/\1xV/g;			
			print OUT $kantex;
			$list[$i] =~ s/॥/||/g;
			print OUT $list[$i];	
			$prev = 0;
			$vflag = 0;
			$hl_count = 0;			
			$kantex = "";			
		}
		else
		{
			$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;			
			$kantex =~ s/R($vy_kan)X/\1xR/;
			$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
			$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
			$kantex =~ s/V($vy_kan)x/\1xV/g;			
			print OUT $kantex;
			$list[$i] =~ s/॥/||/g;
			print OUT $list[$i];			
		}
		#print $hex . "\n";
		#print OUT $list[$i];
		$kantex = "";
	}
}

if($kantex ne "")
{
	if($prev == 4)
	{
		$kantex =~ s/a/f/;
	}
	$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;
	$kantex =~ s/R($vy_kan)X/\1xR/;
	$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
	$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
	$kantex =~ s/V($vy_kan)x/\1xV/g;	
	print OUT $kantex . "\n";
}

#print OUT "\n";
$line = <IN>;
}

close(IN);
close(OUT);

sub Convert_to_TeX()
{
	my($unicode) = @_;


	if(is_swara($unicode))
	{
		#print $unicode . "-->" . " is swara-" . $swara_a{$unicode}. "\n";
		if( ($kantex ne "") && ($prev == 4) )
		{
			$kantex =~ s/a/f/;
			print OUT $kantex . " ";						
		}
		elsif($kantex ne "")
		{
			print OUT $kantex;
		}
		print OUT $swara_a{$unicode};
		#print "#################-s\n";
		$prev = 1;
		$vflag = 0;
		$hl_count = 0;
		$kantex = "";
	}
	elsif(is_vyanjana($unicode))
	{
		$vflag++;
		if($vflag == 1)
		{
			$kantex = $kantex . $vyanjana_a{$unicode} . "a";
		}
		elsif($vflag > 1)
		{
			if( ($prev == 4) && ($hl_count == 1) )
			{
				$kantex = $kantex . $vyanjana_a{$unicode} . "x";
			}
			elsif( ($prev == 4) && ($hl_count > 1) )
			{
				$kantex = $kantex . $vyanjana_a{$unicode} . "X";
			}
		}
		
		if( ($vflag > 1) && ( ($hl_count == 0) || ( ($vflag-1) != $hl_count ) ) )
		{
			$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;
			$kantex =~ s/R($vy_kan)X/\1xR/;
			$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
			$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
			$kantex =~ s/V($vy_kan)x/\1xV/g;			
			print OUT $kantex;
			#print "#################-v($vflag($hl_count))\n";			
			$hl_count = 0;
			$vflag = 1;
			$uni_string = "";
			$kantex  = "";
			$kantex = $kantex . $vyanjana_a{$unicode} . "a";			
		}
		#print $unicode . "-->" . " is vyanjana\n";
		$prev = 2;
		$uni_string = $uni_string . ";" . $unicode;
	}
	elsif(is_number($unicode))
	{
		if($kantex ne "")
		{
			print OUT $kantex;
		}		
		$kantex = $numbers_a{$unicode};
		print OUT $kantex;		
		#print $unicode . "-->" . " is a kannada numeral\n";
		$prev = 3;
		$uni_string = "";
		$kantex = "";
	}
	elsif(is_halanta($unicode))
	{
		#print $unicode . "-->" . " is a halanta\n";
		$hl_count++;
		$prev = 4;
		$uni_string = $uni_string . ";" . $unicode;		
	}
	elsif(is_symbol($unicode))
	{
		$uni_string = $uni_string . ";" . $unicode;
		if($unicode eq "CC3")
		{
			if($hl_count)
			{
				$kantex = $kantex . "q";
			}
			else
			{
				$kantex =~ s/a/aq/;				
			}
		}
		else
		{
			$kantex =~ s/a/$symbols_a{$unicode}/;			
		}
		$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;
		$kantex =~ s/R($vy_kan)X/\1xR/;
		$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
		$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
		$kantex =~ s/V($vy_kan)x/\1xV/g;			
		print OUT $kantex;
		#print $unicode . "-->" . " is a symbol\n";
		#print "#################-sy\n";
		$hl_count = 0;
		$vflag = 0;
		$prev = 5;
		$uni_string = "";
		$kantex = "";
	}
	elsif(is_MH($unicode))
	{
		if($unicode eq "C82")
		{
			$kantex = $kantex . "M";
		}
		elsif($unicode eq "C83")
		{
			$kantex = $kantex . "H";
		}
		$kantex =~ s/r(f|a|A|i|iV|u|U|e|eV|eY|o|oV)($vy_kan)x/\2\1R/;
		$kantex =~ s/R($vy_kan)X/\1xR/;
		$kantex =~ s/V($vy_kan)x($vy_kan)X($vy_kan)X/\1x\2X\3XV/g;
		$kantex =~ s/V($vy_kan)x($vy_kan)X/\1x\2XV/g;
		$kantex =~ s/V($vy_kan)x/\1xV/g;		
		print OUT $kantex;		
		#print $unicode . "-->" . " is either anuswara or visarga\n";
		$hl_count = 0;
		#$sym_flag = 1;
		$vflag = 0;
		#print "#################MH\n";
		$prev = 6;
		$kantex = "";
	}

}

sub DecToNumBase
{
  my $decNumber = $_[0];
  my $numBase = $_[1];
  my $numNumber = '';

  while($decNumber ne 'end') 
  {
    # divide the decimal number by $numBase and 
    # store the remainder (modulus function) in 
    # the temporary variable $temp
    my $temp = $decNumber % $numBase;
    if($temp > 9) 
    {
      $temp = chr($temp + 55);
    }
    $numNumber = $temp . $numNumber;
    $decNumber = int($decNumber / $numBase);
    if($decNumber < $numBase) 
    {
      if($decNumber > 9) 
      {
        $decNumber = chr($decNumber + 55);
      }
      $numNumber = $decNumber . $numNumber;
      $decNumber = 'end'; 
    } 
  }
  return $numNumber;
}

sub is_swara()
{
	my($unicode) = @_;

	if($unicode =~ /$swara/)
	{
		return(1);
	}
	else
	{
		return(0);
	}

}

sub is_vyanjana()
{
	my($unicode) = @_;

	if($unicode =~ /$vyanjana/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_number()
{
	my($unicode) = @_;

	if($unicode =~ /$numbers/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_halanta()
{
	my($unicode) = @_;

	if($unicode =~ /CCD/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_symbol()
{
	my($unicode) = @_;

	if($unicode =~ /$symbols/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

sub is_MH()
{
	my($unicode) = @_;

	if($unicode =~ /C82|C83/)
	{
		return(1);
	}
	else
	{
		return(0);
	}
}

