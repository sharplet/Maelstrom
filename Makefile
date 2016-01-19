default: run

run: build
	.build/debug/read

build:
	swift build

clean:
	swift build -k
