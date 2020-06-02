FROM nimmis/java-centos:openjdk-7-jdk

RUN yum -y upgrade

# firefox
RUN yum -y install firefox

# chrome
ADD /google-chrome.repo /etc/yum.repos.d/google-chrome.repo
RUN yum -y install google-chrome-stable
RUN yum -y install unzip

# xvfb
RUN yum -y install xorg-x11-server-Xvfb libXtst xdpyinfo
ENV DISPLAY :99
ENV LD_LIBRARY_PATH /usr/lib64/

RUN mkdir /grid

# selenium grid
ADD http://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar /grid/selenium-server-standalone-2.45.0.jar
ADD /run-node.sh /grid/run-node.sh
ADD /run-hub.sh /grid/run-hub.sh

ADD http://chromedriver.storage.googleapis.com/2.15/chromedriver_linux64.zip /chromedriver_linux64.zip
RUN unzip /chromedriver_linux64.zip -d /grid
RUN rm -f chromedriver_linux64.zip

# video
ADD /selenium-utils-gridvideo-1.4.2.jar /grid/selenium-utils-gridvideo-1.4.2.jar