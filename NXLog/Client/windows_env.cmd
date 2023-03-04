@( Set "_= (
REM " ) <#
)
@Echo Off
SetLocal EnableExtensions DisableDelayedExpansion
set powershell=powershell.exe

REM Use this if you need 64-bit PowerShell (has no effect on 32-bit systems).
REM if defined PROCESSOR_ARCHITEW6432 (
REM set powershell=%SystemRoot%\SysNative\WindowsPowerShell\v1.0\powershell.exe
REM )

REM Use this if you need 32-bit PowerShell.
REM if NOT %PROCESSOR_ARCHITECTURE% == x86 (
REM set powershell=%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
REM )

%powershell% -ExecutionPolicy Bypass -NoProfile ^
-Command "iex ((gc '%~f0') -join [char]10)"
EndLocal & Exit /B %ErrorLevel%
#>

# PowerShell code starts here.

# To make NXLog return an error, write to standard error and exit 1
if ($false) {
    [Console]::Error.WriteLine("This is an error")
    exit 1
}
else {
# Anything written to standard output is used as configuration content
        $winbuild = (Get-CimInstance Win32_OperatingSystem).Version
        $architecture = (Get-WmiObject CIM_OperatingSystem).OSArchitecture
	$versionarray = (Get-CimInstance Win32_OperatingSystem).Version.Split(".")
	$majorversion = $versionarray[0]
	$minorversion = $versionarray[1]
        if ($architecture -like "64-bit"){
                $architecture = "x86_64"
        }else{
                $architecture = "x86"
        }
        $osname = (Get-WmiObject -Class Win32_OperatingSystem).caption
        Write-Output "define ARCHITECTURE $architecture"
        Write-Output "define FAMILY windows"
        Write-Output "define HOSTTYPE windows"
        Write-Output "define PLATFORM windows"
        Write-Output "define OSNAME $osname"
        Write-Output "define WINBUILD $winbuild"
        Write-Output "define HOSTVER $majorversion.$minorversion"
}