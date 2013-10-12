if [[ $# -ne 4 ]]
then
		echo "usage : $0 <dossierInformations> <dossierModele> <dossierIntermediaire> <seuil>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierModele=$2
dossierIntermediaire=$3
seuil=$4

perl $dir/proposition.pl $dossierIntermediaire/prediction.svm $dossierModele/entrainement.feat $dossierInformations $seuil
