FROM maven:3-jdk-8  
ADD . $MAVEN_HOME  
  
RUN cd $MAVEN_HOME \  
&& mvn -B clean package -Pdocker-build \  
&& mv $MAVEN_HOME/target /signing \  
&& export DEBIAN_FRONTEND=noninteractive \  
&& apt update \  
&& apt install -y ruby \  
&& gem install --no-ri --no-rdoc asciidoctor-pdf --pre \  
&& rm -r /var/lib/apt/lists \  
&& rm -r $MAVEN_HOME  
  
ONBUILD ADD . /signing/docs  
ONBUILD RUN ["sh", "/signing/bin/prepare-docs.sh"]  
  
ONBUILD VOLUME /signing/conf  
ONBUILD VOLUME /singing/storage  
  
ONBUILD EXPOSE 8080  
ONBUILD ENTRYPOINT []  
ONBUILD CMD ["sh", "/signing/bin/run.sh"]  

