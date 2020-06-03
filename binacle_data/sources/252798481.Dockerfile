FROM ubuntu:trusty  
  
MAINTAINER Denis Trifonov <destrifonov@gmail.com>  
  
# install packages  
RUN apt-get update && apt-get install -y \  
git ca-certificates \  
python-twisted \  
\--no-install-recommends && \  
apt-get clean && \  
apt-get autoremove && \  
rm -rf /var/lib/apt/lists/*  
  
# pulling applications  
WORKDIR /tmp  
RUN git clone https://github.com/graphite-project/carbon.git  
RUN git clone https://github.com/graphite-project/ceres.git  
RUN git clone https://github.com/graphite-project/whisper.git  
  
# install carbon  
WORKDIR /tmp/carbon  
RUN git checkout megacarbon  
RUN python setup.py install  
  
# install ceres database  
WORKDIR /tmp/ceres  
RUN git checkout master  
RUN python setup.py install  
  
# install whisper database  
WORKDIR /tmp/whisper  
RUN git checkout master  
RUN python setup.py install  
  
# clean up  
RUN rm -rf /tmp/* /var/tmp/*  
  
# define volume for override carbon daemon configuration  
VOLUME /opt/graphite/conf/carbon-daemons  
  
# expose carbon daemon ports  
EXPOSE 2003 2004 7002  
# define default command on start container  
WORKDIR /opt/graphite/bin  
CMD ["./carbon-daemon.py", "--debug", "example", "start"]

