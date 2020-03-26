FROM microsoft/iis:latest
SHELL ["powershell"]
RUN mkdir C:\site
ADD . /site
RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \  
    Install-WindowsFeature Web-Asp-Net45
RUN Remove-WebSite -Name 'Default Web Site' 
RUN Install-WindowsFeature Web-Windows-Auth

#These are only needed for accessing the IIS admin UI
#RUN net user localadmin Qwerty123456 /add
#RUN net localgroup Administrators localadmin /add 
#RUN Install-WindowsFeature Web-Mgmt-Service
#RUN New-ItemProperty -Path HKLM:\software\microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1 -Force
#RUN Start-Service WMSVC
#These are only needed for accessing the IIS admin UI

#Enable Windows Authenticaiton on the site
RUN Import-module IISAdministration; \
    New-IISSite -Name "Site" -PhysicalPath C:\site -BindingInformation "*:80:"
RUN C:\windows\system32\inetsrv\appcmd.exe set config "Site" -section:system.webServer/security/authentication/anonymousAuthentication /enabled:"False" /commit:apphost
RUN  C:\windows\system32\inetsrv\appcmd.exe set config "Site" -section:system.webServer/security/authentication/windowsAuthentication /enabled:"True" /commit:apphost
EXPOSE 80



