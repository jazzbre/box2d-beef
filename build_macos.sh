./submodules/bx/tools/bin/darwin/genie --gcc=osx-x64 gmake
make -C .build/projects/gmake-osx-x64 config=debug -j 8
make -C .build/projects/gmake-osx-x64 config=release -j 8
