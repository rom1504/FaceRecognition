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

mkdir -p $dossierModele
mkdir -p $dossierIntermediaire

echo tosvm...
adir=`pwd`
cd $dir
make
cd $adir
$dir/tosvm.sh $dossierInformations $dossierPhotosDecoupees $dossierModele $dossierIntermediaire
echo scale...
$dir/scale.sh $dossierIntermediaire
echo svm...
$dir/svm.sh $dossierModele $dossierIntermediaire
echo proposition...
$dir/proposition.sh $dossierInformations $dossierModele $dossierIntermediaire

