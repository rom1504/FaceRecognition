use strict;
use File::Basename;
use File::Copy;
use File::Remove 'remove';

if((scalar @ARGV)!=5)
{
	print("usage: $0 <prediction> <liste> <features> <dossierProposition> <dossierTest>");
}
my ($prediction,$liste,$features,$proposition,$test)=@ARGV;

if(!(-d "$proposition")) { mkdir "$proposition"; }
else { remove(\1,"$proposition/*"); }

open(my $ffeatures,"<",$features);
my %mfeatures=map {$_ =~ s/\s+$//; my @a=split("\t",$_);$a[1]=>$a[0]} (<$ffeatures>);
close($ffeatures);

open(my $fliste,"<",$liste);
open(my $fprediction,"<",$prediction);

my ($ligneListe,$lignePrediction);
while(($ligneListe=<$fliste>) && ($lignePrediction=<$fprediction>))
{
	$ligneListe=~ s/\s+$//;
	$lignePrediction=~ s/\s+$//;
	my @liste=split("\t",$ligneListe);
	my $dossier=$proposition."/".$mfeatures{$lignePrediction};
	my $fichier=$liste[1];
	if(!(-d $dossier)) { mkdir $dossier; }
	copy $test."/".$liste[0]."/".$fichier,$dossier."/".(basename $fichier);
}
close($fliste);
close($fprediction);