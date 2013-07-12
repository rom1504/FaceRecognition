echo Test:
perl evaluation.pl ../sortie/prediction.svm ../intermediaire/corpusTest/liste.txt ../modele/entrainement.feat
echo ""
echo Cross Validation:
perl evaluation.pl ../sortie/predictionCV.svm ../intermediaire/corpusCrossValidation/liste.txt ../modele/entrainement.feat