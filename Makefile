default: run

run: build
	.build/debug/write

build:
	swift build

clean:
	swift build -k
