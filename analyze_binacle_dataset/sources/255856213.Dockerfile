FROM microsoft/iis:latest  
SHELL ["powershell"]

RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \  
    Install-WindowsFeature Web-Asp-Net45

COPY WebAppLegacy WebAppLegacy  
RUN Remove-WebSite -Name 'Default Web Site'  
RUN New-Website -Name 'guidgenerator' -Port 80 \  
    -PhysicalPath 'c:\WebAppLegacy' -ApplicationPool '.NET v4.5'

EXPOSE 80

CMD ["ping", "-t", "localhost"] 