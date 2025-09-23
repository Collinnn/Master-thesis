Hello, here the paper will go and the current latex version, this will be git Integrated soon :tm:

Installation requirements:
gcc11 and g++11
Commands
cmake -G Ninja llvm/llvm -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_TARGETS_TO_BUILD=host -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_EXTERNAL_PROJECTS=circt -DLLVM_EXTERNAL_CIRCT_SOURCE_DIR=$PWD -DCIRCT_SLANG_FRONTEND_ENABLED=ON
ninja -j 1 -C build check-circt
PS: -j 1 is just because my laptop is memory limited. Setting this value up is more jobs done at the same time. 
If memory limit is reached, ninja shuts down, but you can restart it without problems from the compile point.   