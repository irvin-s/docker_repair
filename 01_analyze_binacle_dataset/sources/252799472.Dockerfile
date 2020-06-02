# STAGE0  
FROM microsoft/dotnet:latest as builder  
  
MAINTAINER Christian Sakshaug <christian@dx.no>  
  
RUN mkdir /tools/ -p  
COPY files/. /tools/  
  
# STAGE1  
FROM microsoft/dotnet:latest  
# COPY FROM STAGE0 SO WE DONT TAKE WITH SECRETS  
COPY \--from=builder /tools /tools  

