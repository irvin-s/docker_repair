# escape=`

# base image on which custom image is based on
FROM microsoft/windowsservercore

# argument ipaddress used during building of image
# refers to pull server ip address
ARG  ipaddress="0.0.0.0"

# argument port used during building of image
# refers to pull server port
# used for accesing pull server
ARG  port="9100"

# argument regkey used during building of image
# refers to pull server registration key
ARG  regkey="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# argument sqlUsername used during building of image
# used in changing connection string in web.config
ARG  sqlUsername="xxxxxxxxx"

# argument sqlPassword used during building of image
# used in changing connection string in web.config
ARG  sqlPassword="xxxxxxxxx"

# argument sqlPassword used during building of image
# used in changing connection string in web.config
ARG  sqlServer="xxxxxxxxx"

# argument sqlPassword used during building of image
# used in changing connection string in web.config
ARG  databaseName="xxxxxxxxx"

# installing IIS and its related windows feature
RUN powershell -Command  Install-WindowsFeature web-server, Web-Default-Doc, `
            Web-Dir-Browsing, Web-Http-Errors, Web-Static-Content, Web-Http-Logging, `
            Web-Request-Monitor, Web-Stat-Compression, Web-Filtering, Web-Windows-Auth, `
            Web-Net-Ext45, Web-Asp-Net45, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Metabase

# installing .NET 4.5 
RUN ["Powershell", "install-windowsfeature","NET-Framework-45-Core" ]

# creating a new Docker folder
RUN powershell -Command New-Item -Path c:\docker -ItemType Directory -Force

# Registering Nuget as Package source
RUN powershell -Command Register-PackageSource -Name Nuget `
            -Location https://api.nuget.org/v3/index.json `
            -ProviderName Nuget -Trusted -Force -ForceBootstrap 

# Registering Chocolatey as Package source
RUN powershell -Command Register-PackageSource -Name chocolatey `
                -Location http://chocolatey.org/api/v2/ `
                -ProviderName chocolatey -Trusted -Force -ForceBootstrap 

# installing xWebAdministration DSC resources 
RUN powershell -Command install-module -Name xWebAdministration `
                                -RequiredVersion 1.14.0.0 `
                                -Force -Confirm:$false -Verbose

# installing xWebDeploy DSC resources 
RUN powershell -Command install-module -Name xwebdeploy `
                                    -RequiredVersion 1.2.0.0  `
                                    -Force -Confirm:$false -Verbose

# removing default iisstrart.htm file
RUN powershell -Command Remove-Item C:\inetpub\wwwroot\iisstart.htm 

# removing default iisstrart.png file
RUN powershell -Command Remove-Item C:\inetpub\wwwroot\iisstart.png 

# removing default web site website from IIS
RUN powershell -Command Remove-Website -Name 'Default Web Site'

# removing default application pool from IIS
RUN powershell -Command Remove-WebAppPool -Name 'DefaultAppPool'

# adding lcm.ps1 to docker folder created previously
ADD lcm.ps1 c:\docker

# adding ChangeConnectionString.ps1 to docker folder created previously
ADD ChangeConnectionString.ps1 c:\docker

# executing lcm.ps1 for changing the LCM configuration of image
# the LCM should pull configuration from pull server
# specified in parameters
RUN powerShell -Command c:\docker\lcm.ps1 -port %port% -regKey %regkey% -ipaddress %ipaddress%


# Download Chocolatey installar and install the same
RUN powershell -Command install-package -name webdeploy -ProviderName chocolatey -RequiredVersion 3.5.2 -Force -ForceBootstrap -Verbose

# adding the web application file from deployment folder
ADD \Deployment C:\Deployment

# changing the current working directory to deployment folder
WORKDIR C:\\Deployment

# execute the webdeploy package commandline from deployment folder
RUN C:\Deployment\OnlinePharmacy.deploy.cmd /Y

# execute ChangeConnectionString.ps1 and change connectionstring in web.config
RUN powerShell -Command c:\docker\ChangeConnectionString.ps1 -sqlUsername %sqlUsername% -sqlPassword %sqlPassword% -sqlServer %sqlServer% -databaseName %databaseName%

CMD powershell -command while ($true) { Start-Sleep -Seconds 3600 }









