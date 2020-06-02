# escape=`
FROM microsoft/mssql-server-windows-express:2016-sp1-windowsservercore-10.0.14393.1715

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Add files
ADD ./install /install

# Set workdir
WORKDIR /install

# Set defaults for required (when running) env variables
ENV ACCEPT_EULA=Y
ENV sa_password=HASH-epsom-sunset-cost7!

# Install databases
ARG SQL_DB_PREFIX="Sitecore"
ENV SQL_PACKAGE_EXE='C:\Program Files (x86)\Microsoft SQL Server\*\DAC\bin\SqlPackage.exe'
RUN $name = '{0}_Core' -f $env:SQL_DB_PREFIX; & $env:SQL_PACKAGE_EXE /a:Publish /sf:'./Sitecore.Core.dacpac' /tdn:$name /tsn:$env:COMPUTERNAME; `
    $name = '{0}_Master' -f $env:SQL_DB_PREFIX; & $env:SQL_PACKAGE_EXE /a:Publish /sf:'./Sitecore.Master.dacpac' /tdn:$name /tsn:$env:COMPUTERNAME; `
    $name = '{0}_Web' -f $env:SQL_DB_PREFIX; & $env:SQL_PACKAGE_EXE /a:Publish /sf:'./Sitecore.Web.dacpac' /tdn:$name /tsn:$env:COMPUTERNAME; `
    $name = '{0}_ExperienceForms' -f $env:SQL_DB_PREFIX; & $env:SQL_PACKAGE_EXE /a:Publish /sf:'./Sitecore.ExperienceForms.dacpac' /tdn:$name /tsn:$env:COMPUTERNAME

# Reset workdir
WORKDIR /

# Cleanup
RUN Remove-Item 'C:/install' -Force -Recurse