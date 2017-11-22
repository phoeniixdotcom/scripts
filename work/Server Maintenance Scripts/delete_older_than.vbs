'
'
' Name:
' backuplogs.vbs
'
' Description:
' Deletes all files in the current directory (and optionally, all sub-directories) '
' that are older than the given number of days.
'
' Usage:
' delete_older_than #days [folder] [-s] [-l]
'
' where
' #days number of days to keep
' folder name of folder containing files to delete (default is current) '
' -s delete in sub-directories also (optional)
' -l list files to delete withoout deleting them (optional)

' Audit:
' 2000/01/14 jdeg created
' 2004/07/08 updated by Ben
'

numfiles = 0

set wso = CreateObject("Wscript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")
set arg = Wscript.Arguments

'check the command line arguments

if arg.count = 0 then
howto = array( _
"delete_older_than ## [folder] [-e:<extension>] [-s] [-l]", _
"", _
" ## " & vbtab & "is the number of days to keep", _
" folder" & vbtab & "is the folder (current by default) to do the deletes in", _
" -e:extension" & vbtab & "specifies the extension of the files to delete",_
" " & vbtab & "(default ='*'. example e:txt for text files)", _
" -s " & vbtab & "does the delete on all sub-folders", _
" -l " & vbtab & "list files to delete without actually deleting them", _
"", _
" You are not asked to verify the delete so use caution")
wscript.echo join(howto,vbcrlf)
wscript.quit
end if

'set defaults

numdays = -1
subfold = false
delete = true
folder = fso.GetAbsolutePathName(".")
extension = "*"

'get any values specified on the command line

for i = 0 to arg.count - 1
if isnumeric(arg(i)) then
numdays = cint(arg(i))
else
if arg(i) = "-s" then
subfold = true
elseif arg(i) = "-l" then
delete = false
elseif Left(arg(i),2) = "-e" Then
      extarray = split(arg(i),":")
If UBound(extarray)=1 Then
      ' we have the correct format      
      If (Len(extarray(1))>0) Then extension = extarray(1)
      End if
else
folder = arg(i)
end if
end if
Next

'check for missing or invalid (less than zero) numdays parameter

if numdays < 0 then
wscript.echo "You didn't specify the number of days"
wscript.quit
end if

'add ending "\" to folder name
' ************not needed**************************
'if right(folder,1) <> "\" then folder = folder & "\"

'determine the cutoff date (the oldest date retained)
cutoff = DateAdd("d",-numdays,date())

'clean up the given folder
Call CleanFolder(folder,extension,cutoff,subfold,delete)


'
'
' This function does the actual deleting. It was made into a separate function so that '
' it could be called recursively if the subfolders option was selected.
'
'
'

sub CleanFolder (ByVal foldername, ByVal extension, ByVal cutoff, ByVal subfolders, ByVal delete)

dim fold 'the current folder object '
dim file 'for stepping through the files collection '
dim files 'the files collection within a folder '
dim folder 'for stepping through the subfolders collection '
dim folders 'the subfolders collection within a folder '
dim filename 'fully qualified name of file to delete '
Dim attrib 'attribute flag '
Dim oFile                'file itself '

'get a collection of all files in the folder
set fold = fso.GetFolder(foldername)
set files = fold.files

'process all the files in the folder
for each file in files
datestamp = CDate(Month(file.datelastmodified) & "/" & Day(file.datelastmodified) & "/" & Year(file.datelastmodified))
if datestamp < cutoff then
filename = foldername & "\" & file.name
numfiles = numfiles + 1

If fso.GetExtensionName(filename)=extension or extension="*" Then
if delete Then
                                        ' Check file for read only attribute - mxs
                                        Set oFile = fso.GetFile(filename)
                                        attrib = oFile.Attributes
                                        If (attrib And &H01) < 1 Then
     ' wscript.echo "Deleting file: " & datestamp & " - " & filename
      fso.DeleteFile filename
      Else
           ' wscript.echo filename & " appears to be read only. Skipping Delete."
      End If
Else
wscript.echo "Would Delete file: " & datestamp & " - " & filename & " - [" & DateDiff("d", datestamp, Date()) & " days old]"
End If
End If
End if
next

'process all the subfolders in the folder
if subfolders then
set folders = fold.subfolders
for each folder in folders
call CleanFolder(folder.path,extension,cutoff,subfolders,Delete)
next
end if
End sub