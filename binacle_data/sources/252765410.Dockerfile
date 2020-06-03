FROM microsoft/powershell:ubuntu16.04  
MAINTAINER Ryan Lee <ryan@ryanl.ee>  
  
RUN powershell -Command "Install-Package -Name AzureRM.NetCore.Preview -Force"  
  
ENTRYPOINT [ "powershell" ]  
CMD [ "-Help" ]  

