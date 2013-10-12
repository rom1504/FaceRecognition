use List::Util "sum";
use File::Basename;
use strict;

# ce que je vais faire : 
# 1) lire fichierTest.txt et fichierCrossValidation.txt pour générer les sets correspondants
# 2) lire en parallèle informations et informationsSansTests et entrer les informations en fonction des tests
# 3) calculer
# non ce fichier n'évalue qu'un seul ensemble qu'on passe en paramètre


if((scalar @ARGV)!=3)
{
	print("usage: $0 <dossierInformations> <dossierInformationsSansTests> <fichierEnsembleAEvaluer>\n");
	exit 1;
}
my ($dossierInformations,$dossierInformationsSansTests,$fichierEnsembleAEvaluer)=@ARGV;

open(my $ffichierEnsembleAEvaluer,"<",$fichierEnsembleAEvaluer);
my %ensembleAEvaluer=map { my $ligne=$_ ; $ligne =~ s/\s+$//; $ligne => 1 } <$ffichierEnsembleAEvaluer>;
close($ffichierEnsembleAEvaluer);


my (%true,%predicted,%actual);

my %classes;
my @fichiers=split("\n",`find -L $dossierInformations -type f | sed 's,^'$dossierInformations'/,,'`);
foreach my $fichier (@fichiers)
{
	my $bfichier=$fichier;
	$fichier=$dossierInformations."/".$fichier;
	open(my $ffichier,"<",$fichier);
	open(my $ffichier2,"<",$dossierInformationsSansTests."/".$bfichier);
	my $ligne;
	my $ligne2;
	while(($ligne=<$ffichier>) && ($ligne2=<$ffichier2>))
	{
		$ligne =~ s/\s+$//;
		my ($x,$y,$w,$h,$fichierDecoupe,$personne,$valide,$ignore)=split("\t",$ligne);
		$ligne2  =~ s/\s+$//;
		my ($x2,$y2,$w2,$h2,$fichierDecoupe2,$personne2,$valide2,$ignore2)=split("\t",$ligne2);
		if(($fichierDecoupe eq $fichierDecoupe2) && (exists $ensembleAEvaluer{$fichierDecoupe}))
		{
			if($personne2 ne "")
			{
				if(!exists($predicted{$personne2})) {$predicted{$personne2}=0;}
				$predicted{$personne2}++;
			}
			if(!exists($actual{$personne})) {$actual{$personne}=0;}
			$actual{$personne}++;
			if($personne eq $personne2) {if(!exists($true{$personne})) {$true{$personne}=0;} $true{$personne}++;}
			if($personne2 ne "")
			{
				$classes{$personne2}=1;
			}
			$classes{$personne}=1;
		}
	}
	close($ffichier);
}

my @classes=keys %classes;

foreach my $classe (@classes)
{
	if(!exists($predicted{$classe})) {$predicted{$classe}=0;}
	if(!exists($actual{$classe})) {$actual{$classe}=0;}
	if(!exists($true{$classe})) {$true{$classe}=0;}
}


sub round
{
	my $precision=defined(@_[1]) ? @_[1] : 0;
	return int(@_[0]*10**@_[1]+0.5)/(10**@_[1]);
}

my $arrondi=2;

my (%recall,%precision,%fmesure);
foreach (@classes)
{
	$recall{$_}=$actual{$_}==0 ? 1 : $true{$_}/$actual{$_};
	$precision{$_}=$predicted{$_}==0 ? 1 : $true{$_}/$predicted{$_};
	$fmesure{$_}=$recall{$_}+$precision{$_}==0 ? 0 : 2*$recall{$_}*$precision{$_}/($recall{$_}+$precision{$_});
	print("$_ : Actual=".round($actual{$_},$arrondi)." Predicted=".round($predicted{$_},$arrondi)." True=".round($true{$_},$arrondi)." Recall=".round($recall{$_},$arrondi)." Precision=".round($precision{$_},$arrondi)." Fmesure=".round($fmesure{$_},$arrondi)."\n");
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