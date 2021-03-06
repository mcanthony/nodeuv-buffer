
DEPS ?= gyp libuv

all: build test

.PHONY: deps
deps: $(DEPS)

gyp: deps/gyp
deps/gyp:
	git clone --depth 1 https://chromium.googlesource.com/external/gyp.git ./deps/gyp

libuv: deps/libuv
deps/libuv:
	git clone --depth 1 git://github.com/libuv/libuv.git ./deps/libuv

build: $(DEPS)
	deps/gyp/gyp --depth=. -Goutput_dir=./out -Icommon.gypi --generator-output=./build -Dlibrary=static_library -Duv_library=static_library -f make

.PHONY: test
test: ./test/test.cc
	make -C ./build/ test
	cp ./build/out/Release/test ./test/test

