if [[ $# -ne 2 ]]
then
		echo "usage : $0 <dossierModele> <dossierIntermediaire>" 
		exit 1
fi
dossierModele=$1
dossierIntermediaire=$2

svm-train -c 8.0 -g 0.0001220703125 $dossierIntermediaire/entrainementScaled.svm $dossierModele/modele.svm > /dev/null
#svm-train -t 2 $dossierIntermediaire/entrainementScaled.svm $dossierModele/modele.svm > /dev/null
svm-predict $dossierIntermediaire/testScaled.svm $dossierModele/modele.svm $dossierIntermediaire/prediction.svm > /dev/null