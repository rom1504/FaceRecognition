dir=`dirname $0`

dossierInformations=$dir/../donnees/informations
dossierPhotosDecoupees=$dir/../donnees/photosDecoupees
dossierModele=$dir/../donnees/modele
dossierIntermediaire=$dir/../donnees/intermediaire
seuil=0.8

bash $dir/chaineSimplifie.sh $dossierInformations $dossierPhotosDecoupees $dossierModele $dossierIntermediaire $seuil
