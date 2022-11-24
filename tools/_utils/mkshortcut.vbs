If WScript.Arguments.Count <> 3 Then
	WScript.Echo "Usage: mkshortcut LINK TARGET WORKINGDIR"
	WScript.Quit 1
End If

sLink = WScript.Arguments.Item(0)
sTarget = WScript.Arguments.Item(1)
sWorkingDir = WScript.Arguments.Item(2)

Set oShell = WScript.CreateObject("WScript.Shell")
Set oFileSystem = WScript.CreateObject("Scripting.FileSystemObject")

sLink = oFileSystem.GetAbsolutePathName(sLink)
sTarget = oFileSystem.GetAbsolutePathName(sTarget)
sWorkingDir = oFileSystem.GetAbsolutePathName(sWorkingDir)

Set oShortcut = oShell.CreateShortcut(sLink)
oShortcut.TargetPath = sTarget
oShortcut.WorkingDirectory = sWorkingDir
oShortcut.Save
