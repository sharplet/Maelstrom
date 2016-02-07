default: run

run: build
	.build/debug/stdio

build:
	swift build

clean:
	swift build -k
