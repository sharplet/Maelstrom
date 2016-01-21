default: run

run: build
	.build/debug/seek

build:
	swift build

clean:
	swift build -k
