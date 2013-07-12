#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <iostream>
#include <stdio.h>

using namespace std;
using namespace cv;


int main( int argc, const char** argv )
{
	Mat frame, frameCopy, image;
	image = imread( argv[1], 1 );
	int w=50,h=50; // ( 30 presque pareil au niveau des résultats et un peu plus rapide )
	Mat gray, smallImg( w, h, CV_8UC1 );
	//cvtColor( image, gray, CV_BGR2GRAY );
	resize( image, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
 	//equalizeHist( smallImg, smallImg );
	for(int x=0;x<w;x++)
	{
		for(int y=0;y<h;y++)
		{
			//cout<<x*(w+1)+y<<":"<<int(smallImg.at<char>(x, y))<<" ";
			cout<<3*(x*(w+1)+y)<<":"<<int(smallImg.at<Vec3b>(x, y)[0])<<" ";
			cout<<3*(x*(w+1)+y)+1<<":"<<int(smallImg.at<Vec3b>(x, y)[1])<<" ";
			cout<<3*(x*(w+1)+y)+2<<":"<<int(smallImg.at<Vec3b>(x, y)[2])<<" ";
		}
	}
	cout<<"\n";
	return 0;
}