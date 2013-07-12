use List::Util "sum";
use strict;

if((scalar @ARGV)!=3)
{
	print("usage: $0 <prediction> <liste> <features>");
}
my ($prediction,$liste,$features)=@ARGV;

open(my $ffeatures,"<",$features);
my %mfeatures=map {$_ =~ s/\s+$//; my @a=split("\t",$_);$a[1]=>$a[0]} (<$ffeatures>);
close($ffeatures);

open(my $fliste,"<",$liste);
open(my $fprediction,"<",$prediction);

my ($ligneListe,$lignePrediction);
my (%true,%predicted,%actual);
foreach (values %mfeatures)
{
	$true{$_}=0;
	$predicted{$_}=0;
	$actual{$_}=0;
}
while(($ligneListe=<$fliste>) && ($lignePrediction=<$fprediction>))
{
	$ligneListe=~ s/\s+$//;
	$lignePrediction=~ s/\s+$//;
	my @liste=split("\t",$ligneListe);
	$predicted{$mfeatures{$lignePrediction}}++;
	$actual{$liste[0]}++;
	if($mfeatures{$lignePrediction} eq $liste[0]) { $true{$liste[0]}++; }
}
close($fliste);
close($fprediction);

sub round
{
	my $precision=defined(@_[1]) ? @_[1] : 0;
	return int(@_[0]*10**@_[1]+0.5)/(10**@_[1]);
}

my $arrondi=2;

my (%recall,%precision,%fmesure);
foreach (values %mfeatures)
{
	$recall{$_}=$actual{$_}==0 ? 1 : $true{$_}/$actual{$_};
	$precision{$_}=$predicted{$_}==0 ? 1 : $true{$_}/$predicted{$_};
	$fmesure{$_}=$recall{$_}+$precision{$_}==0 ? 1 : 2*$recall{$_}*$precision{$_}/($recall{$_}+$precision{$_});
	print("$_ : Recall=".round($recall{$_},$arrondi)." Precision=".round($precision{$_},$arrondi)." Fmesure=".round($fmesure{$_},$arrondi)."\n");
}

sub mean
{
	return sum(@{@_[0]})/(scalar @{@_[0]});
}

sub doubleImage
{
	my ($hash1,$hash2)=@_;
	my ($tab1,$tab2)=((),());
	foreach (keys %$hash1)
	{
		push(@$tab1,$hash1->{$_});
		push(@$tab2,$hash2->{$_});
	}
	return ($tab1,$tab2);
}

sub ponderedMean
{
	my ($donnees,$poids)=@_;
	my $moy=0;
	for(my $i=0;$i<scalar @$donnees;$i++)
	{
		$moy+=($donnees->[$i])*($poids->[$i]);
	}
	return $moy/(sum(@$poids));
}

my ($grecall,$gprecision,$gfmesure,$accuracy);
# $grecall=mean([values %recall]);
# $gprecision=mean([values %precision]);
$grecall=ponderedMean(doubleImage(\%recall,\%actual));
$gprecision=ponderedMean(doubleImage(\%precision,\%actual));
$gfmesure=2*$grecall*$gprecision/($grecall+$gprecision);
$accuracy=sum(values %true)/sum(values %actual);
print("Général : Recall=".round($grecall,$arrondi)." Precision=".round($gprecision,$arrondi)." Fmesure=".round($gfmesure,$arrondi)." Accuracy=".round($accuracy,$arrondi)."\n");