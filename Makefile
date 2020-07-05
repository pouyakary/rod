build:
	crystal build rod.cr -o ./build/rod

run: build
	./build/rod ./sample.rod