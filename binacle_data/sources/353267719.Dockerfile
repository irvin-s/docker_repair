FROM java:8

WORKDIR /

RUN apt-get update && apt-get install -y mysql-client

ADD ${project.build.finalName}.jar /
ADD run.sh /

RUN chmod +x run.sh

ENTRYPOINT /run.sh ${project.build.finalName}

EXPOSE ${server.port}
