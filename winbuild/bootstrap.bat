REM downloads all tools required to build doxygen on Windows
REM the only prerequisite is chocolatey ( https://chocolatey.org/ )
REM run in an elevated shell
REM made by https://github.com/sidiandi

choco install 7zip wget python -y

wget -nc https://heanet.dl.sourceforge.net/project/winflexbison/win_flex_bison-latest.zip
7z x win_flex_bison-latest.zip -y -oflex
set PATH=%~dp0flex;%PATH%

wget -nc ftp://ftp.zlatkovic.com/libxml/zlib-1.2.5.win32.zip
7z x zlib-1.2.5.win32.zip -y -otools
robocopy /s %~dp0tools\zlib-1.2.5.win32\bin %~dp0tools

wget -nc ftp://ftp.zlatkovic.com/libxml/iconv-1.9.2.win32.zip
7z x iconv-1.9.2.win32.zip -y -otools
robocopy /s %~dp0tools\iconv-1.9.2.win32\bin %~dp0tools

wget -nc ftp://ftp.zlatkovic.com/libxml/libxml2-2.7.8.win32.zip
7z x libxml2-2.7.8.win32.zip -y -otools
robocopy /s %~dp0tools\libxml2-2.7.8.win32\bin %~dp0tools

set PATH=%~dp0tools;%PATH%

git clone https://github.com/sidiandi/doxygen.git
cd doxygen
cmake -G "Visual Studio 14 2015" -Dwin_static=ON  .

"C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" doxygen.sln /p:Configuration=Release /p:Platform=Win32