
FROM microsoft/windowsservercore-insider
LABEL Name=infragravity/sonar-samples-webapi Version=0.0.1 
LABEL Maintainer=info@infragravity.com

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Invoke-WebRequest https://github.com/infragravity/sonar-docker/releases/download/v0.1.9/sonar-0190-win10-x64.zip -OutFile Sonar.zip
RUN Expand-Archive Sonar.zip -DestinationPath \sonar
WORKDIR /out
COPY ./out .
ADD ./out/Sonard.config c:/sonar
ADD ./out/Sonard.dll.config c:/sonar/out
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Install-WindowsFeature Web-Server
#uncomment to install ASP.NET
#RUN Install-WindowsFeature Web-Asp-Net-45
RUN New-IISSite -Name "AspNetCore" -PhysicalPath c:\out\ -BindingInformation "*:8000:"
RUN Set-WSManInstance WinRM/Config/Service -ValueSet @{AllowUnencrypted=\"true\"}
RUN sc.exe create sonard binpath= c:\sonar\out\Sonard.exe start= auto obj= LocalSystem depend= \"WinRM\"
ENTRYPOINT ["powershell.exe", ""]
