use File::Basename;
     use List::Util qw(reduce);
if((scalar @ARGV)!=4)
{
	print("usage: $0 <dossierClasses> <fichierFeatures> <fichierSVM> <entrainement ou test>");
	exit(1);
}
#créer liste fichiers (dans le bon ordre) : va servir pour l'évaluation et l'exploitation de prediction.svm : dans separer.pl
my ($classes,$features,$svm,$type)=@ARGV;
my @dossiers=grep {-d $_} (glob("$classes/*"));
my $i=0;
my %features=();
if($type eq "test")
{
	open(my $ffeatures,"<",$features);
	%features=map {$_ =~ s/\s+$//; my @a=split("\t",$_);$a[0]=>$a[1]} (<$ffeatures>);
	close($ffeatures);
}
open(my $fsvm,">",$svm);
foreach my $dossier (@dossiers)
{
	my $d=basename($dossier);
	if($type eq "entrainement")
	{
		$features{$d}=$i;
	}
	my @fichiers=glob("$dossier/*");
	foreach my $fichier (@fichiers)
	{
		open(my $r,"../bin/tosvm $fichier |");
		print($fsvm $features{$d}." ".(<$r>));
		close($r);
	}
	$i++;
}
if($type eq "entrainement")
{
	open(my $ffeatures,">",$features);
	print($ffeatures (reduce {$a.$b."\t".$features{$b}."\n"} "",(keys %features)));
	close($ffeatures);
}
close($fsvm);