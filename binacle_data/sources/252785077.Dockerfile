FROM microsoft/dotnet:1.1.0-sdk-msbuild-rc4  
MAINTAINER CodinGame <coders@codingame.com>  
COPY entrypoint.sh /  
COPY build /project/  
  
ENTRYPOINT ["/entrypoint.sh"]  

