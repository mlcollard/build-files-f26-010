# Build for srcComplexity

.PHONY:all
all : srccomplexity srcMLXPathCountTest

# srccomplexity
srccomplexity : srcComplexity.o srcMLXPathCount.o
	g++ -std=c++17 $^ -lxml2 -o $@

srcComplexity.o : srcComplexity.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c $<

srcMLXPathCount.o : srcMLXPathCount.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -I/usr/include/libxml2 -c $<

# srcMLXPathCountTest
srcMLXPathCountTest : srcMLXPathCountTest.o srcMLXPathCount.o
	g++ -std=c++17 $^ -lxml2 -o $@

srcMLXPathCountTest.o : srcMLXPathCountTest.cpp srcMLXPathCount.hpp
	g++ -std=c++17 -c $<

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
