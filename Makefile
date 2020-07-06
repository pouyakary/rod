build: clean
	crystal build rod.cr -o ./build/rod

clean:
	rm -rf ./build
	mkdir ./build

run: build
	clear
	./build/rod ./sample.rod

install: build
	sudo mv ./build/rod /usr/local/bin