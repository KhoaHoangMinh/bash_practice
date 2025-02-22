

final: calc.o operations.o
	@echo "Linking and producing the final application"
	g++ calc.o operations.o	-o calc
	@chmod +x calc

calc.o: src/calc.cpp
	@echo "Compiling calc.cpp"
	g++ -c src/calc.cpp

operations.o: src/operations.cpp
	@echo "Compiling operations.cpp"
	g++ -c src/operations.cpp

clean: 
	@echo "Removing everything but the source file"
	rm calc operations.o calc.o

