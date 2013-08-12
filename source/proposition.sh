if [[ $# -ne 3 ]]
then
		echo "usage : $0 <dossierInformations> <dossierModele> <dossierIntermediaire>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierModele=$2
dossierIntermediaire=$3

perl $dir/proposition.pl $dossierIntermediaire/prediction.svm $dossierModele/entrainement.feat $dossierInformations
