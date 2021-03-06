use File::Basename;
use List::Util qw(reduce max);
if((scalar @ARGV)!=5)
{
	print("usage: $0 <dossierInformations> <dossierPhotosDecoupees> <fichierFeatures> <fichierSVM> <entrainement ou test>\n");
	exit(1);
}
#créer liste fichiers (dans le bon ordre) : va servir pour l'évaluation et l'exploitation de prediction.svm : dans separer.pl
my ($informations,$photosDecoupees,$features,$svm,$type)=@ARGV;
my $max=0;
my %features=();

if($type eq "test")
{
	open(my $ffeatures,"<",$features);
	%features=map {$_ =~ s/\s+$//; my @a=split("\t",$_);$a[0]=>$a[1]} (<$ffeatures>);
	close($ffeatures);
	$max=max (values %features);
}

	
open(my $fsvm,">",$svm);
my @fichiers=split("\n",`find -L $informations -type f`);

foreach my $fichier (@fichiers)
{
# 	print($fichier."\n");
	open(my $ffichier,"<",$fichier);
	my $ligne;
	while($ligne=<$ffichier>)
	{
		$ligne =~ s/\s+$//;
		my ($x,$y,$w,$h,$fichierDecoupe,$personne,$valide,$ignore)=split("\t",$ligne);
		if($x ne "" && $y ne "" && $w ne "" && $h ne "" && $fichierDecoupe ne ""
		&& (($type eq "entrainement" && $personne ne "" && $valide eq "1" && $ignore eq "0") || ($type eq "test" && $personne eq "" && $ignore ne "1")))
		{
			if($type eq "entrainement" && !(exists $features{$personne}))
			{
				$max++;
				$features{$personne}=$max;
			}
			open(my $r,dirname($0)."/../bin/tosvm $fichierDecoupe |");
			my $feature=$type eq "entrainement"  ? $features{$personne} : "0";# no idea whether I should put 0 or nothing or... : 0 : man svm-predict
			print($fsvm $feature." ".(<$r>));
			close($r);
		}
	}
	close($ffichier);
}
if($type eq "entrainement")
{
	open(my $ffeatures,">",$features);
	print($ffeatures (reduce {$a.$b."\t".$features{$b}."\n"} "",(keys %features)));
	close($ffeatures);
}

close($fsvm);
