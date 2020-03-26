FROM blitznote/debase:16.04
# 17.10
MAINTAINER bard.lind@gmail.com

#RUN apt-get -q update

RUN /usr/bin/curl -k -O https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz 
RUN ls
RUN  tar xzvf openjdk-10_linux-x64_bin.tar.gz && \ 
  mkdir /usr/lib/jvm && \
  chpst -u root mv jdk-10 /usr/lib/jvm/java-10-openjdk-x64/ && \
  rm openjdk-10_linux-x64_bin.tar.gz
ENV PATH="/usr/lib/jvm/java-10-openjdk-x64/bin:${PATH}"

RUN chpst -u root update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-10-openjdk-x64/bin/java 1
RUN chpst -u root update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-10-openjdk-x64/bin/javac 1
RUN java -version
