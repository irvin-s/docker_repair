FROM alpine  
MAINTAINER Daniel Stange <daniel.stange@die-interaktiven.de>  
RUN apk update  
RUN apk add bash  
RUN apk add openssh  
RUN apk add git  
RUN apk add openjdk8  
RUN apk add apache-ant --update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \  
\--allow-untrusted  
RUN wget -qO- $DX_CLI_URL | tar xJf -  
RUN ./sfdx/install  
COPY salesforce_ant/ant-salesforce.jar /usr/share/java/apache-ant/lib/  
ENV ANT_HOME /usr/share/java/apache-ant  
ENV PATH $PATH:$ANT_HOME/bin

