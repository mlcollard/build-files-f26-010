# Build for srcComplexity

.PHONY:all
all : srccomplexity srcMLXPathCountTest

srccomplexity : srcComplexity.o srcMLXPathCount.o
	g++ -std=c++17 srcComplexity.o srcMLXPathCount.o -lxml2 -o srccomplexity

srcComplexity.o : srcComplexity.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c srcComplexity.cpp

srcMLXPathCount.o : srcMLXPathCount.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -I/usr/include/libxml2 -c srcMLXPathCount.cpp

srcMLXPathCountTest.o : srcMLXPathCountTest.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c srcMLXPathCountTest.cpp

srcMLXPathCountTest : srcMLXPathCountTest.o srcMLXPathCount.o
	g++ -std=c++17 srcMLXPathCountTest.o srcMLXPathCount.o -lxml2 -o srcMLXPathCountTest

.PHONY:clean
clean :
	rm -f srccomplexity srcComplexity.o srcMLXPathCount.o srcMLXPathCountTest srcMLXPathCountTest.o
