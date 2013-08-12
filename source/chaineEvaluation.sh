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

mkdir -p $dossierModele
mkdir -p $dossierIntermediaire

echo separer...
bash $dir/separer.sh $dossierInformations $dossierIntermediaire

echo chaine sur sans tests...
bash $dir/chaineSimplifie.sh $dossierIntermediaire/informationsSansTests/ $dossierPhotosDecoupees $dossierModele $dossierIntermediaire

echo evaluation...
bash $dir/evaluation.sh $dossierInformations $dossierIntermediaire
