FROM scratch  
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>  
ADD ./stage/wait-for-weave /home/weavewait/wait-for-weave  
VOLUME /home/weavewait  
ENTRYPOINT ["/home/weavewait/wait-for-weave"]

