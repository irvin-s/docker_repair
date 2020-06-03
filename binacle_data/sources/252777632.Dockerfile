FROM otechlabs/java8:40.26  
MAINTAINER anthrax-0 <ivan.ivanyuk@gmail.com>  
  
COPY jprofiler_agent_linux-x64.tar.gz /tmp/  
WORKDIR /tmp  
RUN gunzip -c jprofiler_agent_linux-x64.tar.gz | tar -xf - ;\  
mkdir -p /opt/jprofiler; mv ./bin /opt/jprofiler/ ; \  
rm -rf jprofiler_agent_linux-x64.tar.gz  
WORKDIR /  

