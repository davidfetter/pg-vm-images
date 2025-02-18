$ErrorActionPreference = "Stop"

mkdir c:\t
cd c:\t

echo "downloading visual studio installer"
curl.exe -sSL -o c:\t\vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe
if (!$?) { throw 'cmdfail' }

echo "starting visual studio installation"
Start-Process -Wait `
    -FilePath c:\t\vs_buildtools.exe `
    -ArgumentList `
      '--quiet', '--wait', '--norestart', '--nocache', `
      '--installPath', 'c:\BuildTools', `
      '--add', 'Microsoft.VisualStudio.Component.VC.Tools.x86.x64', `
      '--add', 'Microsoft.VisualStudio.Component.Windows10SDK.20348'
if (!$?) { throw 'cmdfail' }

cd c:\
Remove-Item C:\t -Force -Recurse
Remove-Item -Force -Recurse ${Env:TEMP}\*
Remove-Item -Force -Recurse "${Env:ProgramData}\Package Cache"
