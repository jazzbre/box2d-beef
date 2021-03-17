./submodules/bx/tools/bin/linux/genie --gcc=linux-gcc gmake
make -C .build/projects/gmake-linux config=debug64 -j 8
make -C .build/projects/gmake-linux config=release64 -j 8
