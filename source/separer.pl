use File::Basename;
use File::Copy;
use File::Remove 'remove';
use File::Path qw(make_path);
use strict;
if((scalar @ARGV)!=6)
{
	print("usage: $0 <informationsInitial> <informationsSansTests> <fichierTest> <fichierCrossValidation> <proportionTest> <proportionCrossValidation>\n");
	exit 1;
}
my ($informationsInitial,$informationsSansTests,$fichierTest,$fichierCrossValidation,$proportionTest,$proportionCrossValidation)=@ARGV;


# ce que ça doit faire : lire chaque fichier d'info d'un dossier info initial
# si identification non ignoré : 

# dans l'idée : récupérer identification reconnu et validé non ignoré, les partager aléatoirement en 3 ensembles de taille 70% 15% 15%
# puis réenregistrer le tout

# réalisation :
# en c++ avec mon modèle déjà implémenté ce serait assez trivial, pas nécessairement...
# réfléchir, ça doit pouvoir se faire en qq lignes

# j'ai besoin de stocker les identifications bonnes et de savoir où les enregistrer (avec les autres)

# idée simple : tout mettre dans un hash de list (équivalent de PersonneMap)
# et faire un tableau avec les bonnes identification avec un moyen simple de vérifier qu'elles sont dans ce tableau ou pas
# une fois que c'est fait partager le tableau en 3
# une fois le tableau partagé en 3 enregistrer tout 3 fois en changeant de tableau-filtrant à chaque fois

# moyen simple (bien qu'un peu stupide) de filtrer : dans ce tableau stocker l'emplacement de la photoDecoupee, c'est un identifiant unique
# si on veut que la photoDecoupee soit facultative un jour, une possibilité simple sera de regénérer le nom, mais ce n'est pas d'actualité

# bien plus qu'à le faire

# plan simple :
# 1) stocker tout dans un hash
# 2) générer 2 tableau pour test et cross validation
# 3) enregistrer le tout où il faut

#  début de truc à compléter, modifier

my %identifications;

my $count=0;
my @fichiers=split("\n",`find -L $informationsInitial -type f`);

foreach my $fichier (@fichiers)
{
	$identifications{$fichier}=[];
	open(my $ffichier,"<",$fichier);
	my $ligne;
	while($ligne=<$ffichier>)
	{
		$ligne =~ s/\s+$//;
		my ($x,$y,$w,$h,$fichierDecoupe,$personne,$valide,$ignore)=split("\t",$ligne);
		if($x ne "" && $y ne "" && $w ne "" && $h ne "" && $fichierDecoupe ne "" && $personne ne "" && $valide eq "1" && $ignore eq "0") {$count++;}
		push(@{$identifications{$fichier}},$ligne);
	}
	close($ffichier);
}

# print(@{$identifications{"donnees/informations//p_large_f1sd_542400084a195c72.jpg.txt"}});

# print($count."\n");# 151

my $nbSet=int($count*$proportionTest);
my %testSet;
while((scalar(keys %testSet)) != $nbSet) {$testSet{int(rand($count))}=1;}

my $nbCrossValidation=int($count*$proportionCrossValidation);
my %crossValidationSet;
while((scalar(keys %crossValidationSet)) != $nbCrossValidation) {my $r=int(rand($count)); if(!(exists $testSet{$r})) {$crossValidationSet{$r}=1;}}

# print(join ' ',(keys %crossValidationSet));


open(my $ffichierTest,">",$fichierTest);
open(my $ffichierCrossValidation,">",$fichierCrossValidation);
my $i=0;
foreach my $fichier (keys %identifications)
{
	my $pfichier=$fichier;
	$pfichier=~s/^$informationsInitial\///;
	make_path(dirname($informationsSansTests."/".$pfichier));
	open(my $ffichier,">",$informationsSansTests."/".$pfichier);
	foreach my $identification (@{$identifications{$fichier}})
	{
		my ($x,$y,$w,$h,$fichierDecoupe,$personne,$valide,$ignore)=split("\t",$identification);
		if($x ne "" && $y ne "" && $w ne "" && $h ne "" && $fichierDecoupe ne "" && $personne ne "" && $valide eq "1" && $ignore eq "0")
		{
			if(exists $testSet{$i})
			{
				$identification=$x."\t".$y."\t".$w."\t".$h."\t".$fichierDecoupe."\t".""."\t".""."\t"."";
				print($ffichierTest ($fichierDecoupe."\n"));
			}
			
			if(exists $crossValidationSet{$i})
			{
				$identification=$x."\t".$y."\t".$w."\t".$h."\t".$fichierDecoupe."\t".""."\t".""."\t"."";
				print($ffichierCrossValidation ($fichierDecoupe."\n"));
			}
			$i++;
		}
		print($ffichier $identification."\n");
	}
	close($ffichier);
}
close($ffichierTest);
close($ffichierCrossValidation);

# perl source/newseparer.pl donnees/informations/ intermediaire/informationsSansTests/ intermediaire/fichierTest.txt intermediaire/fichierCrossValidation.txt


# reste plus qu'à générer 2 fichier contenant les nom des photos découpées choisis et enlever ces photos decoupees du nouveau dossier 

# j'aimerais faire un tag quand j'aurais fait marcher à peu près tout ce que je veux et que ça marche correctement (déjà ça va beaucoup plus vite de faire les reconnaissance via le logiciel qu'à la main)