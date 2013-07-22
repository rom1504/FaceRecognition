if [[ $# -ne 2 ]]
then
		echo "usage : $0 <dossierInformations> <dossierIntermediaire>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierIntermediaire=$2


echo Test:
perl $dir/newevaluation.pl $dossierInformations $dossierIntermediaire/informationsSansTests/ $dossierIntermediaire/fichierTest.txt
echo ""
echo Cross Validation:
perl $dir/newevaluation.pl $dossierInformations $dossierIntermediaire/informationsSansTests/ $dossierIntermediaire/fichierCrossValidation.txt