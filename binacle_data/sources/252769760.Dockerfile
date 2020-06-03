FROM node:5  
MAINTAINER Arnau Siches <asiches@gmail.com>  
  
RUN apt-get update -qyy \  
&& apt-get install -qyy \  
bzip2 \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN npm install -g mermaid phantomjs  
  
WORKDIR /data  
  
# ENTRYPOINT ["mermaid"]  
# CMD ["--help"]  
CMD ["mermaid", "--help"]  

