dir=`dirname $0`

dossierInformations=$dir/../donnees/informations
dossierPhotosDecoupees=$dir/../donnees/photosDecoupees
dossierModele=$dir/../donnees/modele
dossierIntermediaire=$dir/../donnees/intermediaire
# 0.7 donne une valeur de 0.96 de précision contre 0.8 normalement (mais avec une perte de recall importante)
seuil=0.7
proportionTest=0.5
proportionCrossValidation=0

bash $dir/chaineEvaluation.sh $dossierInformations $dossierPhotosDecoupees $dossierModele $dossierIntermediaire $seuil $proportionTest $proportionCrossValidation
