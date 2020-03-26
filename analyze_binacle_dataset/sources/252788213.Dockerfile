FROM alpine  
MAINTAINER TriCore Reference Laboratories - Dan Lang  
RUN apk update  
RUN apk add bash  
RUN apk add openjdk8  
RUN apk add apache-ant --update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \  
\--allow-untrusted  
#Copy over the dependent libraries for running JavaScript in Ant/Java  
COPY Ant_libs/bsf.jar /usr/share/java/apache-ant/lib/  
COPY Ant_libs/js.jar /usr/share/java/apache-ant/lib/  
COPY Ant_libs/commons-logging-1.2.jar /usr/share/java/apache-ant/lib/  
ENV ANT_HOME /usr/share/java/apache-ant  
ENV PATH $PATH:$ANT_HOME/bin

