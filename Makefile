default: run

run: build
	.build/debug/rename

build:
	swift build

clean:
	swift build -k
