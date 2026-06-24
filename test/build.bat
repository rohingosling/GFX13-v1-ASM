@echo off
rem =============================================
rem  GFX-13 v1 Test Suite - Build Script
rem  Assembler: Borland Turbo Assembler (TASM)
rem  Compiler:  Borland Turbo C++ 3.1 (C++ mode)
rem =============================================
rem
rem  Usage: Run this batch file from the test
rem         directory. TASM and BCC must be on
rem         the PATH.
rem
rem  All output is logged to build.log.
rem
rem  Memory model: small (default).
rem =============================================

echo ============================================ >build.log
echo  GFX-13 v1 Test Suite - Build Script >>build.log
echo  Assembler: Borland Turbo Assembler (TASM) >>build.log
echo  Compiler:  Borland Turbo C++ 3.1 (C++ mode) >>build.log
echo ============================================ >>build.log
echo. >>build.log

echo [1/9] Assembling gfx13.asm... >>build.log
rem Assemble from inside src\ so TASM sees simple, single-directory paths.
rem (A multi-segment source path such as ..\src\gfx13.asm makes TASM treat the
rem  object operand as a directory and write gfx13.obj\gfx13.OBJ, which fails.)
cd ..\src
tasm /ml gfx13.asm,gfx13.obj >>..\test\build.log
if errorlevel 1 goto fail_asm
cd ..\test
goto compile
:fail_asm
cd ..\test
goto fail
:compile

echo [2/9] testpix.c... >>build.log
bcc -1 -P -I..\src testpix.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [3/9] testline.c... >>build.log
bcc -1 -P -I..\src testline.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [4/9] testrect.c... >>build.log
bcc -1 -P -I..\src testrect.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [5/9] testtri.c... >>build.log
bcc -1 -P -I..\src testtri.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [6/9] testquad.c... >>build.log
bcc -1 -P -I..\src testquad.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [7/9] testimg.c... >>build.log
bcc -1 -P -I..\src testimg.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [8/9] testpal.c... >>build.log
bcc -1 -P -I..\src testpal.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo [9/9] testclip.c... >>build.log
bcc -1 -P -I..\src testclip.c ..\src\gfx13.obj >>build.log
if errorlevel 1 goto fail

echo. >>build.log
echo ============================================ >>build.log
echo  All 8 tests built successfully. >>build.log
echo ============================================ >>build.log
goto end

:fail
echo. >>build.log
echo *** BUILD FAILED *** >>build.log

:end
type build.log

echo Build finished. See build.log for details.
