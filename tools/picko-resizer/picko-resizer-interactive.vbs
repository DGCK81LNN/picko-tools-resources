Set oShell = WScript.CreateObject("WScript.Shell")
'Set oFSO = CreateObject("Scripting.FileSystemObject")

sReply = InputBox("multiplier", "picko-resizer-interactive", "2")
If Not IsEmpty(sReply) Then
	oShell.Run ".\picko-resizer.exe " & sReply, 7 'minimized, no focus
End If
