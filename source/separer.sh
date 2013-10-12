if [[ $# -ne 4 ]]
then
		echo "usage : $0 <dossierInformations> <dossierIntermediaire> <proportionTest> <proportionCrossValidation>" 
		exit 1
fi
dir=`dirname $0`
dossierInformations=$1
dossierIntermediaire=$2
proportionTest=$3
proportionCrossValidation=$4

mkdir -p $dossierIntermediaire/informationsSansTests/

perl $dir/separer.pl $dossierInformations $dossierIntermediaire/informationsSansTests/ $dossierIntermediaire/fichierTest.txt $dossierIntermediaire/fichierCrossValidation.txt $proportionTest $proportionCrossValidation
