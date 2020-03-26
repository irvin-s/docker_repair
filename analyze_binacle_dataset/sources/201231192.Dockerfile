	FROM oneops/centos7

# maven
WORKDIR /opt
ENV apache_archive="http://archive.apache.org/dist"
ENV m_version="3.3.3"
RUN wget -nv ${apache_archive}/maven/maven-3/${m_version}/binaries/apache-maven-${m_version}-bin.tar.gz
RUN tar -xzvf apache-maven-${m_version}-bin.tar.gz -C /usr/local
WORKDIR /usr/local
RUN ln -sf apache-maven-${m_version} maven
RUN touch /etc/profile.d/maven.sh
RUN echo 'export M2_HOME=/usr/local/maven' >> /etc/profile.d/maven.sh
RUN echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
RUN mkdir -p ${OO_HOME}/build/.m2
RUN rm -fr /root/.m2
RUN ln -s ${OO_HOME}/build/.m2 /root/.m2

# oneops
ENV OO_HOME='/home/oneops'
VOLUME ${OO_HOME}
EXPOSE 3001

WORKDIR ${OO_HOME}/build
COPY hudson.tasks.Maven.xml hudson.tasks.Maven.xml
COPY build.sh build.sh
RUN chmod +x build.sh
RUN ln -s /home/oneops/build/build.sh /usr/bin/build
RUN mkdir -p ${OO_HOME}/dist
