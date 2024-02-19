all:
	g++ src/*.cpp -O2 -o isodump

clean:
	rm isodump
