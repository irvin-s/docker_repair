FROM __CONTAINER_REPO__:__LIFERAY_VERSION__
MAINTAINER Milen Dyankov <milen.dyankov@liferay.com>
ENV JAVA_HOME /opt/java 
ENV PATH ${PATH}:${JAVA_HOME}/bin
CMD /usr/bin/liferay
EXPOSE 8080 8009