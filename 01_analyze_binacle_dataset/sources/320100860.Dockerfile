FROM qmu1/jdk8:latest

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN adduser user -h /home/user -D && \
    apk add --no-cache curl graphviz

USER user

# newer schemaspy: http://sourceforge.net/projects/schemaspy/files/schemaspy/
# newer mysql connector: http://dev.mysql.com/downloads/connector/j/
RUN mkdir $HOME/pkg && \
    mkdir $HOME/workdir && \
    mkdir $HOME/conf && \
    curl --silent --location https://github.com/schemaspy/schemaspy/releases/download/v6.0.0-rc1/schemaspy-6.0.0-rc1.jar > $HOME/pkg/schemaSpy.jar && \
    curl --silent --location https://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-5.1.41.tar.gz | tar -C $HOME/pkg/ -xzf - && \
    ln -s mysql-connector-java-5.1.41/mysql-connector-java-5.1.41-bin.jar $HOME/pkg/mysql-conn.jar

WORKDIR /home/user/workdir
ENTRYPOINT ["java", "-jar", "/home/user/pkg/schemaSpy.jar"]
