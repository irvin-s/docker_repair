# escape=`
FROM microsoft/aspnet:4.7.1-windowsservercore-1709

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Default build args, not needed to set when building, unless using a external SQL server
ARG SQL_SERVER="sql"
ARG SQL_USER="sa"
ARG SQL_PASSWORD="HASH-epsom-sunset-cost7!"
ARG SQL_DB_PREFIX="Sitecore"

# Install WebDeploy
ENV WEBDEPLOY_MSI="webdeploy.msi"
ADD http://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi ${WEBDEPLOY_MSI}
RUN Start-Process msiexec.exe -ArgumentList '/i', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait

# Install IIS URL Rewrite
ENV URLREWRITE_MSI="urlrewrite.msi"
ADD http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi ${URLREWRITE_MSI}
RUN Start-Process msiexec.exe -ArgumentList '/i', $env:URLREWRITE_MSI, '/quiet', '/norestart' -NoNewWindow -Wait

# Install SIF
RUN Install-PackageProvider -Name NuGet -Force; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.2.0 -Force

# Remove base image defaults
RUN Remove-Website -Name 'Default Web Site'

# Add files
ADD ./install /install

# Set workdir
WORKDIR /install

# Expand installation files
RUN Expand-Archive -Path '*.zip' -DestinationPath '.'; `
    Expand-Archive -Path '*Configuration files*.zip' -DestinationPath '.'

# Modify config to skip database install
ENV SITENAME="sc"
ENV SIF_CONFIG="./sitecore-XM1-cm.json"
RUN $config = Get-Content $env:SIF_CONFIG | Where-Object { $_ -notmatch '^\s*\/\/'} | Out-String | ConvertFrom-Json; `
    $config.Tasks.InstallWDP.Params.Arguments | Add-Member -Name 'Skip' -Value @(@{'ObjectName' = 'dbDacFx'}, @{'ObjectName' = 'dbFullSql'}) -MemberType NoteProperty; `
    $config.Variables.'Site.PhysicalPath' = 'C:\inetpub\{0}' -f $env:SITENAME; `
    ConvertTo-Json $config -Depth 50 | Set-Content -Path $env:SIF_CONFIG

# Install Sitecore
RUN Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
    -Package "./Sitecore*_cm.scwdp.zip" `
    -LicenseFile "./license.xml" `
    -Sitename $env:SITENAME `
    -SqlDbPrefix $env:SQL_DB_PREFIX `
    -SqlServer $env:SQL_SERVER `
    -SqlAdminUser $env:SQL_USER `
    -SqlAdminPassword $env:SQL_PASSWORD `
    -SqlCoreUser $env:SQL_USER `
    -SqlCorePassword $env:SQL_PASSWORD `
    -SqlMasterUser $env:SQL_USER `
    -SqlMasterPassword $env:SQL_PASSWORD `
    -SqlWebUser $env:SQL_USER `
    -SqlWebPassword $env:SQL_PASSWORD `
    -SqlFormsUser $env:SQL_USER `
    -SqlFormsPassword $env:SQL_PASSWORD `
    -SolrCorePrefix $env:SQL_DB_PREFIX `
    -Skip "RemoveDefaultBinding", "CreateBindingsWithThumprint", "CreateHostHeader", "CreateBindingsWithDevelopmentThumprint", "StartAppPool", "StartWebsite"

# Reset workdir
WORKDIR /

# Remove all url rewite rules, set customErrors, disable dns cache, add config patch
RUN Clear-WebConfiguration -PSPath ('IIS:\Sites\{0}' -f $env:SITENAME) -Filter '/system.webserver/rewrite/rules/rule'; `
    Set-WebConfiguration -PSPath ('IIS:\Sites\{0}' -f $env:SITENAME) -Filter '/system.web/customErrors/@mode' -Value 'Off'; `
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    Copy-Item -Path 'C:/install/*.config' -Destination ('C:/inetpub/{0}/App_Config/Include' -f $env:SITENAME)

# Cleanup
RUN Start-Process msiexec.exe -ArgumentList '/x', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Uninstall-Module SitecoreInstallFramework -Force; `
    Remove-Item 'C:/install' -Force -Recurse; `
    Remove-Item $env:WEBDEPLOY_MSI -Force; `
    Remove-Item $env:URLREWRITE_MSI -Force

# Start site
RUN Start-WebAppPool -Name $env:SITENAME; `
    Start-Website -Name $env:SITENAME