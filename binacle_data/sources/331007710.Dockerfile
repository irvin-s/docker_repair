# escape=`
FROM sxc-solr:9.0.3

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

ADD sxa-solr.json /Files/Config/

RUN /Scripts/WaitForSolr.ps1 "solr"; `
    Install-SitecoreConfiguration -Path "C:\\Files\\Config\\sxa-solr.json"
