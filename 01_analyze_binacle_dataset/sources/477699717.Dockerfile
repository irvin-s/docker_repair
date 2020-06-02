FROM ubuntu
RUN apt-get update;
RUN apt-get update;apt-get -y install git ant fvwm xterm tightvncserver openjdk-11-jdk-headless xfonts-base

#Configure Startup Script
RUN echo "#!/bin/bash" > /opt/start.sh
RUN echo "rm -rf /tmp/.X*" >> /opt/start.sh
RUN echo "vncserver" >> /opt/start.sh
RUN echo "sleep infinity" >> /opt/start.sh
RUN chmod +x /opt/start.sh

#Add main package and VNC information
RUN git clone --depth=1 https://github.com/rusher81572/cloudExplorer.git
WORKDIR /cloudExplorer
RUN ant
RUN mkdir /root/.vnc
RUN echo 123456 | vncpasswd -f > /root/.vnc/passwd
RUN echo "fvwm &" > /root/.vnc/xstartup
RUN echo "exec java -jar /cloudExplorer/dist/CloudExplorer.jar" >> /root/.vnc/xstartup

RUN chmod 600 /root/.vnc/passwd
RUN chmod 777 /root/.vnc/xstartup
ENV USER root
CMD /opt/start.sh
