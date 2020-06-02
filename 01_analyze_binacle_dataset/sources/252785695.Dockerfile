FROM java  
MAINTAINER Jimin Huang "windworship2@163.com"  
ADD /searchEngine_code /workspace  
VOLUME /var/LuceneIndex  
WORKDIR /workspace  
ENV "SERVICE_NAME=searchEngine"  
ENTRYPOINT ["java", "-cp", "lib/*:bin", "com.proj.module.searchEngine.Lucene"]  

