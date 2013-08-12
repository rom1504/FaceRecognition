if [[ $# -ne 1 ]]
then
		echo "usage : $0 <dossierIntermediaire>" 
		exit 1
fi
dossierIntermediaire=$1

svm-scale -s $dossierIntermediaire/scaling_parameters $dossierIntermediaire/entrainement.svm > $dossierIntermediaire/entrainementScaled.svm
svm-scale -r $dossierIntermediaire/scaling_parameters $dossierIntermediaire/test.svm > $dossierIntermediaire/testScaled.svm
