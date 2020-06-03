FROM maven:latest  
  
RUN useradd --create-home user \  
&& mkdir -p /home/user/.m2/repository /cache \  
&& chown -R user:user /home/user/ /cache  
  
ENV MAVEN_CONFIG /home/user/.m2  
  
USER user

