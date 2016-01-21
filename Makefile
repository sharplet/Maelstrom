default: run

run: build
	.build/debug/readwrite

build:
	swift build

clean:
	swift build -k
