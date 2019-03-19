'*************************************************
' This is a self-referencing shortcut type of file
'*************************************************

'adapted from http://superuser.com/questions/140047/how-to-run-a-batch-file-without-launching-a-command-window/390129
ScriptFullPath = Wscript.ScriptFullName
ScriptName = Wscript.ScriptName
RemoveFromPath = ".vbs"
Path = Mid(ScriptFullPath, 1, Len(ScriptFullPath)-Len(ScriptName))
AppName = Mid(ScriptName, 1, Len(ScriptName)-Len(RemoveFromPath))

'Generate the following command
'"thisdir\scripts\run_in_current_cmd.bat" "xxxxxxxx" "arg1" "arg2" "arg3" ...
RunCmd = chr(34) & Path & "scripts\run_in_current_cmd.bat" & chr(34) & " " & chr(34) & AppName & chr(34) 
If WScript.Arguments.Count >= 1 Then
    For i = 0 To WScript.Arguments.Count-1
        Arg = WScript.Arguments(i)
        If InStr(Arg, " ") > 0 Then Arg = chr(34) & Arg & chr(34)
        RunCmd = RunCmd & " " & Arg
    Next
End If

'MsgBox(RunCmd)
CreateObject("Wscript.Shell").Run RunCmd, 0 , True