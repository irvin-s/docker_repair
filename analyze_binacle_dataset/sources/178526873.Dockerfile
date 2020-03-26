FROM tomcat:8.0.33-jre8

# based on: https://jigsaw.w3.org/css-validator/DOWNLOAD.html

# git
RUN apt-get update && \
    apt-get install -y git curl wget software-properties-common

# jdk
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# ant
ENV ANT_VERSION 1.9.7
RUN cd && \
    wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

# css-validator
WORKDIR /opt
RUN git clone --depth=1 --branch=master https://github.com/w3c/css-validator.git

# replace the value of property servlet.lib with the full path to servlet.jar
RUN SERVLET_API_FILE=$(find / -name "servlet-api.jar" | sed -e 's/[\/&]/\\&/g') && \
    sed -i -e "s/\/usr\/share\/java\/servlet-2.3.jar/${SERVLET_API_FILE}/g" /opt/css-validator/build.xml

# build the source
RUN cd /opt/css-validator && \
    ant war && \
    cp css-validator.war ${CATALINA_HOME}/webapps
