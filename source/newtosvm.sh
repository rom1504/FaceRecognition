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

perl $dir/newtosvm.pl $dossierInformations $dossierPhotosDecoupees $dossierModele/entrainement.feat $dossierIntermediaire/entrainement.svm entrainement
perl $dir/newtosvm.pl $dossierInformations $dossierPhotosDecoupees $dossierModele/entrainement.feat $dossierIntermediaire/test.svm test