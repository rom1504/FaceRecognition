use strict;
use File::Basename;
use File::Copy;
use File::Remove 'remove';

if((scalar @ARGV)!=3)
{
	print("usage: $0 <prediction> <features> <dossierInformations>");
}
my ($prediction,$features,$informations)=@ARGV;

open(my $ffeatures,"<",$features);
my %mfeatures=map {$_ =~ s/\s+$//; my @a=split("\t",$_);$a[1]=>$a[0]} (<$ffeatures>);
close($ffeatures);


open(my $fprediction,"<",$prediction);
my @fichiers=split("\n",`find -L $informations -type f`);
foreach my $fichier (@fichiers)
{
	open(my $ffichier,"<",$fichier);
	my @lignes=<$ffichier>;
	close($ffichier);
	my $ligne;
	my $i=0;
	my $j=0;
	foreach my $ligne (@lignes)
	{
		$ligne =~ s/\s+$//;
		my ($x,$y,$w,$h,$fichierDecoupe,$personne,$valide,$ignore)=split("\t",$ligne);
		if($x ne "" && $y ne "" && $w ne "" && $h ne "" && $fichierDecoupe ne ""
		&& $personne eq "" && $ignore ne "1")
		{
			my $lignePrediction=<$fprediction>;
			$lignePrediction=~ s/\s+$//;		
			$personne=$mfeatures{$lignePrediction};
			$valide="0";
			$ignore="0";
			$lignes[$i]=$x."\t".$y."\t".$w."\t".$h."\t".$fichierDecoupe."\t".$personne."\t".$valide."\t".$ignore;
			$j++;
		}
		$i++;
	}
	if($j!=0)
	{
		open(my $ffichier,">",$fichier);
		foreach my $ligne (@lignes) {print($ffichier $ligne."\n");}
		close($ffichier);
	}
}
close($fprediction);

# il faut : lire les fichiers dans le même ordre que tosvm, réécrire les fichiers avec les infos correspondantes
# à vérifier mais je crois que je n'ai pas besoin du fichier liste (qui correspond en fait aux fichiers du dossier informations il semble) : oui c'est ça (avec un mixup des labels déjà dispo pour le test qui n'est plus relevant avec la nouvelle orga des fichiers)
