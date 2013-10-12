if [[ $# -ne 7 ]]
then
		echo "usage : $0 <dossierInformations> <dossierPhotosDecoupees> <dossierModele> <dossierIntermediaire> <seuil> <proportionTest> <proportionCrossValidation>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierPhotosDecoupees=$2
dossierModele=$3
dossierIntermediaire=$4
seuil=$5
proportionTest=$6
proportionCrossValidation=$7

mkdir -p $dossierModele
mkdir -p $dossierIntermediaire

echo separer...
bash $dir/separer.sh $dossierInformations $dossierIntermediaire $proportionTest $proportionCrossValidation

echo chaine sur sans tests...
bash $dir/chaineSimplifie.sh $dossierIntermediaire/informationsSansTests/ $dossierPhotosDecoupees $dossierModele $dossierIntermediaire $seuil

echo evaluation...
bash $dir/evaluation.sh $dossierInformations $dossierIntermediaire
