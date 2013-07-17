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

echo tosvm...
adir=`pwd`
cd $dir
make
cd $adir
$dir/newtosvm.sh $dossierInformations $dossierPhotosDecoupees $dossierModele $dossierIntermediaire
echo scale...
$dir/newscale.sh $dossierIntermediaire
echo svm...
$dir/newsvm.sh $dossierModele $dossierIntermediaire
echo proposition...
$dir/newproposition.sh $dossierInformations $dossierModele $dossierIntermediaire

