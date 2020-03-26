FROM oraclelinux:7-slim

ENV JAVA_HOME=/usr/graalvm-1.0.0-rc1/jdk\
    PATH=/usr/graalvm-1.0.0-rc1/bin:$PATH\
    LEIN_ROOT=ok

RUN yum -y install gcc zlib-devel tar gzip zip

RUN curl -L https://github.com/oracle/graal/releases/download/vm-1.0.0-rc1/graalvm-ce-1.0.0-rc1-linux-amd64.tar.gz |\
    tar zx -C /usr

RUN alternatives --install /usr/bin/java  java  $JAVA_HOME/bin/java  20000 &&\
    alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000 &&\
    alternatives --install /usr/bin/jar   jar   $JAVA_HOME/bin/jar   20000

ADD https://raw.githubusercontent.com/technomancy/leiningen/2.8.1/bin/lein /bin/lein
RUN chmod 755 /bin/lein
RUN lein

ADD lambda_function.py /
ADD profiles.clj /root/.lein/profiles.clj
ADD package.sh /
RUN chmod 755 /package.sh

CMD /package.sh

