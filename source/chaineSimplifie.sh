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

# il faut : paramétriser, changer proposition
# il faut surtout tout paramétriser
# pas mal de choses à changer...
# s'inspirer un peu de facedetect peut être...
# 1) lire les fichiers d'informations
# 2) à partir des fichiers découpés générer un fichier svm de l'entrainement et du test
# 3) à partir des prédictions sur le test compléter les fichiers d'informations

# tosvm.pl : je crois que je vais devoir le recoder totalement, il est spécifique à l'organisation des classes par dossiers
# scale.sh : à paramétrer mais me semble tout à fait bien
# svm.sh : juste à paramétrer, semble bien
# proposition.sh : probablement à refaire totalement comme tosvm.pl, n'est pas adapté à la nouvelle organisation des fichiers

# ce devrait être bcp plus rapide grâce à la nouvelle organisation des fichiers
# et en fait les seuls trucs que je ne change pas (trop) c'est : les scripts qui appellent presque directement svm
# et le tosvm.cpp

# donc à refaire : tosvml.pl, proposition.pl, ensuite paramétrer le reste (ce serait bien que l'ancienne chaine reste soit fonctionnelle comme maintenant, soit adaptée)