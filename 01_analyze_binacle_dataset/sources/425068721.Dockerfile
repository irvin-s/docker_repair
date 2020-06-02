FROM nimmis/java-centos:openjdk-7-jdk

RUN yum -y upgrade

# firefox
RUN yum -y install firefox

# chrome
ADD /google-chrome.repo /etc/yum.repos.d/google-chrome.repo
RUN yum -y install google-chrome-stable
RUN yum -y install unzip
ADD http://chromedriver.storage.googleapis.com/2.15/chromedriver_linux64.zip /chromedriver_linux64.zip
RUN unzip /chromedriver_linux64.zip -d /
RUN rm -f chromedriver_linux64.zip

# xvfb
RUN yum -y install xorg-x11-server-Xvfb libXtst xdpyinfo
ENV DISPLAY :99
ENV LD_LIBRARY_PATH=/usr/lib64/

# Taste
ADD /taste-1.0-beta4-bin.tar.gz /
ENV TASTE_HOME /taste
ENV PATH $PATH:$TASTE_HOME/bin
ADD /run-taste.sh /
RUN chmod +x /run-taste.sh


