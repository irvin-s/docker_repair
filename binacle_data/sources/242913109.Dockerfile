FROM ubuntu
USER root
RUN apt-get update && apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get upgrade -y && apt-get install nodejs -y
RUN mkdir /opt/public
RUN mkdir /opt/bin
ADD public /opt/public
ADD bin /opt/bin
RUN ls -lah /opt/bin
RUN ls -lah /opt/public
ADD run.sh /bin/run.sh
RUN chmod +x /bin/run.sh
RUN cd /opt/bin && npm install
CMD ["/bin/run.sh"]