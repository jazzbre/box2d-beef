solution "box2d"
	configurations {
		"Debug",
		"Release",
	}

	platforms {
		"x32",
		"x64",
		"Native", -- for targets where bitness is not specified
	}

	language "C++"

SOURCE_DIR   = path.getabsolute("../submodules")
local BUILD_DIR = path.getabsolute("../.build")

defines {
}

dofile ("../submodules/bx/scripts/toolchain.lua")
if not toolchain(BUILD_DIR, SOURCE_DIR) then
	return -- no action specified
end

function copyLib()
end

dofile "box2d.lua"
