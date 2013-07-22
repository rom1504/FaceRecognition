if [[ $# -ne 4 ]]
then
		echo "usage : $0 <dossierInformations> <dossierPhotosDecoupees> <dossierModele> <dossierIntermediaire>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierPhotosDecoupees=$2
dossierModele=$3
dossierIntermediaire=$4

echo separer...
$dir/separer.sh $dossierInformations $dossierIntermediaire

echo chaine sur sans tests...
$dir/chaineSimplifie.sh $dossierIntermediaire/informationsSansTests/ $dossierPhotosDecoupees $dossierModele $dossierIntermediaire

echo evaluation...
$dir/evaluation.sh $dossierInformations $dossierIntermediaire
