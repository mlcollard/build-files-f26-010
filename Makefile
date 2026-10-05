# Build for srcComplexity

CXXFLAGS = -std=c++17

.PHONY:all
all : srccomplexity srcMLXPathCountTest

# srccomplexity
srccomplexity : srcComplexity.o srcMLXPathCount.o
	g++ $(CXXFLAGS) $^ -lxml2 -o $@

# srcMLXPathCountTest
srcMLXPathCountTest : srcMLXPathCountTest.o srcMLXPathCount.o
	g++ $(CXXFLAGS) $^ -lxml2 -o $@

# every object file includes the srcMLXPathCount interface
srcComplexity.o srcMLXPathCount.o srcMLXPathCountTest.o : srcMLXPathCount.hpp

# libxml2 headers for the XPath code
srcMLXPathCount.o : CXXFLAGS += -I/usr/include/libxml2

# compile any C++ source file
%.o : %.cpp
	g++ $(CXXFLAGS) -c $<

# run srccomplexity on the demo file
.PHONY:run
run : srccomplexity
	./srccomplexity srcMLXPathCount.cpp.xml

# execute tests
.PHONY:test
test : srcMLXPathCountTest
	./srcMLXPathCountTest

# Generate manpage
.PHONY:manpage
manpage : srccomplexity.1

srccomplexity.1 : srccomplexity.1.md
	lowdown -s -Tman -o srccomplexity.1 srccomplexity.1.md

# View the man page
.PHONY:man
man : manpage
	man ./srccomplexity.1

# delete generated files
.PHONY:clean
clean :
	rm -f srccomplexity srcComplexity.o srcMLXPathCount.o srcMLXPathCountTest srcMLXPathCountTest.o srccomplexity.1
