all:../bin/tosvm
	

../bin/tosvm:tosvm.cpp
	g++ `pkg-config --cflags opencv` -o ../bin/tosvm tosvm.cpp `pkg-config --libs opencv`