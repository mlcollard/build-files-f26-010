# Build for srcComplexity

.PHONY:all
all : srccomplexity srcMLXPathCountTest

srccomplexity : srcComplexity.o srcMLXPathCount.o
	g++ -std=c++17 $^ -lxml2 -o $@

srcComplexity.o : srcComplexity.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c srcComplexity.cpp

srcMLXPathCount.o : srcMLXPathCount.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -I/usr/include/libxml2 -c srcMLXPathCount.cpp

srcMLXPathCountTest.o : srcMLXPathCountTest.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c srcMLXPathCountTest.cpp

srcMLXPathCountTest : srcMLXPathCountTest.o srcMLXPathCount.o
	g++ -std=c++17 $^ -lxml2 -o $@

.PHONY:run
run : srccomplexity
	./srccomplexity srcMLXPathCount.cpp.xml

.PHONY:test
test : srcMLXPathCountTest
	./srcMLXPathCountTest

.PHONY:clean
clean :
	rm -f srccomplexity srcComplexity.o srcMLXPathCount.o srcMLXPathCountTest srcMLXPathCountTest.o
