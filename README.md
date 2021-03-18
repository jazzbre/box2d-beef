# [box2d-beef](https://github.com/jazzbre/box2d-beef) box2d wrapper for the Beef Programming Language

[box2d](https://github.com/jazzbre/box2d) - Actually a box2d fork with liquidfun merged into it!

## Prerequisites
- To initialize submodules run *git submodule update --init --recursive*

## Windows
- Visual Studio 2019 Community/Professional (it can be built with other versions though, check build_windows_vs2019.cmd for more information)
- To build prerequisites run *build_windows_vs2019.cmd*

## MacOS
- To build prerequisites run *./build_macos.sh*

## Linux
- To build prerequisites run *./build_linux.sh*


## Usage
Open workspace and set Example as Startup project and Run!
MacOS/Linux can be built and run with provided VSCode project (expects Beef git clone in the same root folder as this project).

The library is pure C wrapper, so no classes, just structs and "pointers" , intended for people who wish to wrap it their own way.
Example:
```
				b2FixtureDef fd = .();
				fd.shape = shape;
				fd.density = 20.0f;
				fd.friction = 0.1f;

				for (int i = 0; i < 10; ++i)
				{
					b2BodyDef bd = .();
					bd.type = .b2_dynamicBody;
					bd.position = .(-6.0f + 1.0f * i, 11.25f);
					var body = World.CreateBody(world, &bd);
					Body.CreateFixture(body, &fd);
				}
```

## Future work
iOS and Android build scripts.
