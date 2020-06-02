#FROM amonbase:latest
FROM martinrusev/amonbase-arm

RUN echo 'deb http://packages.amon.cx/repo amon contrib' >> /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv AD53961F
RUN apt-get update

RUN apt-get install -y --force-yes amon-agent

RUN /etc/init.d/amon-agent status
RUN /etc/init.d/amon-agent test


RUN amonpm install boo

RUN apt-get remove -y amon-agent
RUN apt-get install -y --force-yes amon-agent

RUN /etc/init.d/amon-agent status
RUN /etc/init.d/amon-agent test


RUN apt-get install -y --force-yes amon-agent


RUN apt-get remove -y amon-agent
RUN apt-get install -y --force-yes amon-agent


CMD ["/bin/bash"]