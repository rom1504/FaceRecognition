svm-scale -s ../intermediaire/scaling_parameters ../intermediaire/entrainement.svm > ../intermediaire/entrainementScaled.svm
svm-scale -r ../intermediaire/scaling_parameters ../intermediaire/test.svm > ../intermediaire/testScaled.svm
svm-scale -r ../intermediaire/scaling_parameters ../intermediaire/crossValidation.svm > ../intermediaire/crossValidationScaled.svm