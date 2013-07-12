perl tosvm.pl ../intermediaire/corpusEntrainement ../modele/entrainement.feat ../intermediaire/entrainement.svm entrainement
perl tosvm.pl ../intermediaire/corpusTest ../modele/entrainement.feat ../intermediaire/test.svm test
perl tosvm.pl ../intermediaire/corpusCrossValidation ../modele/entrainement.feat ../intermediaire/crossValidation.svm test