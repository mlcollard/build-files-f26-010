# Build for srcComplexity

.PHONY:all
all : srccomplexity srcMLXPathCountTest

srccomplexity : srcMLXPathCount.o srcComplexity.o
	g++ -std=c++17 srcMLXPathCount.o srcComplexity.o -lxml2 -o $@

srcComplexity.o : srcComplexity.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c srcComplexity.cpp

srcMLXPathCount.o : srcMLXPathCount.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -I/usr/include/libxml2 -c srcMLXPathCount.cpp

srcMLXPathCountTest : srcMLXPathCount.o srcMLXPathCountTest.o
	g++ -std=c++17 srcMLXPathCount.o srcMLXPathCountTest.o -lxml2 -o $@

srcMLXPathCountTest.o : srcMLXPathCountTest.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c $^

.PHONY:run
run : srccomplexity
	./srccomplexity srcMLXPathCount.cpp.xml

.PHONY:clean
clean :
	@rm -f srcMLXPathCount.o srcComplexity.o srccomplexity srcMLXPathCountTest.o srcMLXPathCountTest
