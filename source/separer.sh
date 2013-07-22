if [[ $# -ne 2 ]]
then
		echo "usage : $0 <dossierInformations> <dossierIntermediaire>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierIntermediaire=$2

perl $dir/separer.pl $dossierInformations $dossierIntermediaire/informationsSansTests/ $dossierIntermediaire/fichierTest.txt $dossierIntermediaire/fichierCrossValidation.txt