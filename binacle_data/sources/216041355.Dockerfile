# escape=`
FROM microsoft/aspnet:4.6.2
SHELL ["powershell"]

ENTRYPOINT ["powershell", "C:\\bootstrap.ps1"]
COPY .\docker\web\bootstrap.ps1 C:\

COPY .\docker\web\SignUp-1.1.msi C:\
RUN Start-Process msiexec.exe -ArgumentList '/i', 'C:\SignUp-1.1.msi', '/quiet', '/norestart' -NoNewWindow -Wait