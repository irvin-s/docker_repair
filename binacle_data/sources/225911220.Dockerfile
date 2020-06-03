FROM microsoft/iis

MAINTAINER Salvatore Realmuto <https://github.com/takhyon>

RUN powershell -NoProfile -Command \
    Add-WindowsFeature NET-Framework-45-ASPNET; \
    Add-WindowsFeature Web-Net-Ext45; \
    Add-WindowsFeature Web-Asp-Net45; \
    Add-WindowsFeature Web-ISAPI-Ext; \
    Add-WindowsFeature Web-ISAPI-Filter

RUN powershell -NoProfile -Command \
    $env:chocolateyUseWindowsCompression = 'false'; \
    "iwr https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression"

RUN powershell -NoProfile -Command \
    choco install chocolatey.server -y; \
    Remove-Item -Path C:\tools\chocolatey.server\App_Data\Packages\Readme.txt

RUN powershell -NoProfile -Command \
    New-WebAppPool -Name chocolatey.server; \
    Set-ItemProperty "IIS:\AppPools\chocolatey.server" -Name "processModel.loadUserProfile" -Value "True"

RUN powershell -NoProfile -Command \
    Import-Module IISAdministration; \
    Import-Module WebAdministration; \
    Remove-WebSite -Name 'Default Web Site'; \
    New-IISSite -Name "Chocolatey" -PhysicalPath C:\tools\chocolatey.server -BindingInformation "*:80:"; \
    Set-ItemProperty "IIS:\Sites\Chocolatey" ApplicationPool chocolatey.server

EXPOSE 80
