FROM codedevote/dotnet-mono:1-sdk  
MAINTAINER codedevote@gmail.com  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \  
&& apt-get install -y nodejs  

