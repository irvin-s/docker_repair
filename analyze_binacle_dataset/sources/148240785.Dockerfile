FROM taskurotta/java-oracle-perf
MAINTAINER Taskurotta <taskurotta@googlegroups.com>

# Install taskurotta server
RUN mkdir /opt/taskurotta
COPY taskurotta.jar /opt/taskurotta
