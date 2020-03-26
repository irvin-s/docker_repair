FROM java  
MAINTAINER Jimin Huang "windworship2@163.com"  
ADD /simple_keyword_code /workspace  
WORKDIR /workspace  
ENV "SERVICE_NAME=model"  
ENTRYPOINT ["java", "-cp", "lib/*:bin", "module.Module"]  

