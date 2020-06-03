
FROM microsoft/windowsservercore
#SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"] 
#RUN set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord 
WORKDIR c:\\app
ADD output/ c:/app
CMD ["cmd", "/C", "Piraeus.Silo.exe"]

