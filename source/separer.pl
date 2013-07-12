#use File::Find;
use File::Basename;
use File::Copy;
use File::Remove 'remove';
use strict;
if((scalar @ARGV)!=4)
{
	print("usage: $0 <source> <entrainement> <test> <crossValidation>\n");
	exit 1;
}
my ($source,$entrainement,$test,$crossValidation)=@ARGV;
#find (sub { push (@fichiers,$File::Find::name) if(!-d); }, $source); : sympa mais pas ce que je veux
my @dossiers=grep {-d $_} (glob("$source/*"));
sub round
{
	return int(@_[0]+0.5);
}

foreach ($entrainement,$test,$crossValidation)
{
	if(!(-d "$_")) { mkdir "$_"; }
	else { remove(\1,"$_/*"); }
}
open(my $flentrainement,">","$entrainement/liste.txt");
open(my $fltest,">","$test/liste.txt");
open(my $flcrossValidation,">","$crossValidation/liste.txt"); # ou faire plutôt dans tosvm et dans ce cas mettre les numéros des classes plutôt que les noms ? ne change pas des masses de choses (en considérant que glob affiche toujours les fichiers dans le même ordre) : bien comme ça
foreach my $dossier (@dossiers)
{
	my $d=basename($dossier);
	my @fichiers=glob("$dossier/*");
	my $nombreTest=round((scalar @fichiers)*20/100);
	my $i=0;
	foreach ($entrainement,$test,$crossValidation) { if(!(-d "$_/$d")) { mkdir "$_/$d"; } }
	foreach my $fichier (@fichiers)
	{
		$i++;
		my $f=basename($fichier);
		my $choix=int(rand(5));
# 		if($i<=$nombreTest) # généraliser (tableau de hash,...) pour racourcir ?
# 		{
# 			copy $fichier,"$test/$d/$f";
# 			print($fltest "$d\t$f\n");
# 		}
# 		elsif($i<=$nombreTest*2)
# 		{
# 			copy $fichier,"$crossValidation/$d/$f";
# 			print($flcrossValidation "$d\t$f\n");
# 		}
# 		else
# 		{
# 			copy $fichier,"$entrainement/$d/$f";
# 			print($flentrainement "$d\t$f\n");
# 		}
		# pas très bien ( à peu près le bon nombre, c'est tout... )
		if($choix==0)
		{
			copy $fichier,"$test/$d/$f";
			print($fltest "$d\t$f\n");
		}
		elsif($choix==1)
		{
			copy $fichier,"$crossValidation/$d/$f";
			print($flcrossValidation "$d\t$f\n");
		}
		else
		{
			copy $fichier,"$entrainement/$d/$f";
			print($flentrainement "$d\t$f\n");
		}
	}
}
close($flentrainement);
close($fltest);
close($flcrossValidation);