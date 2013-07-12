svm-train -c 8.0 -g 0.0001220703125 ../intermediaire/entrainementScaled.svm ../modele/modele.svm > /dev/null
#svm-train -t 2 ../intermediaire/entrainementScaled.svm ../modele/modele.svm > /dev/null
svm-predict ../intermediaire/testScaled.svm ../modele/modele.svm ../sortie/prediction.svm > /dev/null
svm-predict ../intermediaire/crossValidationScaled.svm ../modele/modele.svm ../sortie/predictionCV.svm > /dev/null