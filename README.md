# FaceRecognition
A program made using perl, bash, c++, opencv and libsvm which make it possible to automatically recognize faces.

It takes an information folder as input which contains the tags.
As an output it changes these taggings file by addings the people which are on those tags.

Folders :
* modele : contains the generated svm model
* information : contains the tags files
* photosDecoupees : contains the cut photos
* photos : contains the photo
* intermediaire : contains some temporary svm files

goEvaluation.sh make it possible to evaluate by computing the precision, recall and f-mesure