@echo off

set ANDROID_NDK_ROOT=c:\users\%username%\AppData\Local\Android\sdk\ndk\22.0.7026061
set ANDROID_NDK_ARM=%ANDROID_NDK_ROOT%\toolchains\arm-linux-androideabi-4.9\prebuilt\windows-x86_64
set ANDROID_NDK_ARM64=%ANDROID_NDK_ROOT%\toolchains\aarch64-linux-android-4.9\prebuilt\windows-x86_64
set ANDROID_NDK_X86=%ANDROID_NDK_ROOT%\toolchains\x86-4.9\prebuilt\windows-x86_64
set ANDROID_NDK_LLVM=%ANDROID_NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64

echo  Building Android ARM

submodules\bx\tools\bin\windows\genie --gcc=android-arm ninja
submodules\bx\tools\bin\windows\ninja.exe -C .build/projects/ninja-android-arm/debug32 -j 8 -v
submodules\bx\tools\bin\windows\ninja.exe -C .build/projects/ninja-android-arm/release32 -j 8 -v

echo  Building Android ARM64

submodules\bx\tools\bin\windows\genie --gcc=android-arm64 ninja
submodules\bx\tools\bin\windows\ninja.exe -C .build/projects/ninja-android-arm64/debug64 -j 8 -v
submodules\bx\tools\bin\windows\ninja.exe -C .build/projects/ninja-android-arm64/release64 -j 8 -v

pause