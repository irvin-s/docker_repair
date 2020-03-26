FROM blawlor/spring-xd-base:1.1.1  
MAINTAINER Brendan Lawlor  
  
RUN mkdir -p /tmp/xd/output  
RUN mkdir -p /tmp/xd/input  
RUN chown springxd /tmp/xd/output  
RUN chown springxd /tmp/xd/input  
  
# Replace jackson 2.4.4 files with the 2.5.3 ones. Also add quartz lib.  
RUN rm /opt/spring-xd/xd/lib/jackson-*-2.4.4.jar  
ADD lib/* /opt/spring-xd/xd/lib/  
ADD bin/xd-singlenode.* /opt/spring-xd/xd/bin/  
  
VOLUME /opt/spring-xd/xd/config/  
  
RUN mkdir /opt/spring-xd/xd/custom-modules  
VOLUME /opt/spring-xd/xd/custom-modules  
  
RUN mkdir /opt/spring-xd/rules  
VOLUME /opt/spring-xd/rules  
  
CMD ["xd/bin/xd-singlenode"]  
EXPOSE 9393

