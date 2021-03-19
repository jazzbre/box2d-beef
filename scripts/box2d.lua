project "box2d"
	kind "StaticLib"
	windowstargetplatformversion("10.0")

	defines {
	}

	includedirs {
		path.join(SOURCE_DIR, "box2d/include"),
		path.join(SOURCE_DIR, "box2d/src"),
	}

	files {
		path.join(SOURCE_DIR, "box2d/include/**.h"),
		path.join(SOURCE_DIR, "box2d/src/**.cpp"),
		path.join(SOURCE_DIR, "box2d/src/**.h"),
		path.join(SOURCE_DIR, "../csrc/*.*"),
	}

	configuration {}
