FROM maven:latest
RUN mkdir -p /opt/application
WORKDIR /opt/application
RUN git clone git@git.oschina.net:wuyu15255872976/${project}
WORKDIR /opt/application/${project}
EXPOSE 8080:8080 5005:5005
VOLUME ["/tmp","/root/.m2"]
CMD sh startup.sh