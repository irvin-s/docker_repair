FROM tomcat7_image

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

ADD apps /apps

RUN rm -rf /webapps

ADD webapps /webapps
ADD tomcat_env/setenv.sh /apps/tomcat7/bin/setenv.sh

# Define default command.
CMD /apps/tomcat7/bin/catalina.sh run

