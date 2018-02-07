INC=inc
SRC=src
LIB=lib
BUILD=build

main: ${LIB}/libshared.so ${BUILD}/main.o
	$(CXX) -o main  ${BUILD}/main.o -L${LIB} -lshared

${LIB}/libshared.so: ${SRC}/shared.cpp
	-mkdir -p ${LIB} ${BUILD}
	$(CXX) -fPIC -c ${SRC}/shared.cpp -I${INC} -o ${BUILD}/shared.o
	$(CXX) -shared  -Wl,-soname,libshared.so -o ${LIB}/libshared.so ${BUILD}/shared.o

${BUILD}/%.o: ${SRC}/%.cpp
	$(CXX) -I${INC} -c $< -o $@

clean:
	-rm -rf ${BUILD} 
	-rm -rf ${LIB}
	-rm -rf main
