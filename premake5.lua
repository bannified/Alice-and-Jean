workspace "Ayo"
	architecture "x64"

	configurations 
	{
		"Debug", 
		"Release", -- stripped debug code, optimizations on, but with logging.
		"Dist" -- actual distribution build.
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}" -- Debug-Windows-x64

project "Ayo"
	location "Ayo" -- Relative path of project 
	kind "SharedLib" -- .dll file
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h", -- every .h file
		"%{prj.name}/src/**.cpp" -- every .cpp file
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include",
	}

	filter "system:windows" -- everything under this filter only apply to windows
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines 
		{
			"AYO_PLATFORM_WINDOWS",
			"AYO_BUILD_DLL",
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug" -- just in Debug.
		defines "AYO_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "AYO_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "AYO_DIST"
		symbols "On"

	-- filter { "system:windows", "configurations:Release"} -- for multiple filters.

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"

	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files 
	{
		"%{prj.name}/src/**.h", -- every .h file
		"%{prj.name}/src/**.cpp" -- every .cpp file
	}

	includedirs
	{
		"Ayo/vendor/spdlog/include",
		"Ayo/src"
	}

	links 
	{
		"Ayo"	
	}

	filter "system:windows" -- everything under this filter only apply to windows
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines 
		{
			"AYO_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug" -- just in Debug.
		defines "AYO_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "AYO_RELEASE"
		symbols "On"

	filter "configurations:Dist"
		defines "AYO_DIST"
		symbols "On"

