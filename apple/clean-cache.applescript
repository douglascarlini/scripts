global userCachePath
global userHomePath
global cleanSize
global appName

set userHomePath to POSIX path of (path to home folder) as text
set userCachePath to userHomePath & "/Library/Caches"
set appName to "Limpeza de disco"

tell application "System Events"
	display notification "Calculando, aguarde..." with title appName sound name "default"
end tell

set cleanSize to (do shell script "du -sh " & quoted form of userCachePath & " | awk '{print $1}'") as text
set totalFiles to (do shell script "find " & quoted form of userCachePath & " -type f | wc -l | awk '{print $1}'") as number

set message to "Encontrados " & totalFiles & " arquivos (" & cleanSize & ")"
display notification message with title appName sound name "default"

set message to "Confirma excluir " & totalFiles & " arquivos (" & cleanSize & ")?"
set ageDialog to display dialog message buttons {"Cancelar", "Sim"} default button 1 with icon caution
set buttonResponse to button returned of ageDialog

if buttonResponse is equal to "Cancelar" then
	func1()
else
	func2(cleanSize, userCachePath)
end if

on func1()
	display notification "Limpeza cancelada" with title appName sound name "default"
end func1

on func2()
	tell application "System Events"
		display notification "Limpando, aguarde..." with title appName sound name "default"
	end tell
	do shell script "rm -rf " & quoted form of (userCachePath & "/*") & " 2>/dev/null"
	set message to "Foram liberados " & cleanSize & " de espaço em disco"
	display notification message with title appName sound name "default"
end func2
