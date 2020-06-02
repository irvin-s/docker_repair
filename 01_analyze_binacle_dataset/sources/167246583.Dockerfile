#honeybrid
#start with ubuntu
FROM ubuntu:latest

MAINTAINER Spenser Reinhardt
ENV DEBIAN_FRONTEND noninteractive
ENV logfile /var/log/install.log

RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse'     /etc/apt/sources.list
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list

#dependencies
RUN echo "Installing prereqs" | tee -a "${logfile}"
RUN apt-get update -y 2>&1 | tee -a "${logfile}"
RUN apt-get install automake autoconf git-core make build-essential binutils gcc flex byacc libnetfilter-conntrack-dev libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev libnfnetlink0 pkg-config libc6-dev libglib2.0-0 libglib2.0-dev linux-libc-dev libgloox-dev libxml2-dev libxml++ libpcap0.8-dev libpcap0.8 libdumbnet-dev openssl libssl-dev libev-dev -y 2>&1 | tee -a "${logfile}"

#honeybrid build and install
WORKDIR /tmp/
RUN git clone git://git.code.sf.net/p/honeybrid/git honeybrid-git 2>&1 | tee -a "${logfile}"
WORKDIR honeybrid-git/
RUN autoreconf -vi 2>&1 | tee -a "${logfile}"
RUN ./configure "$@" 2>&1 | tee -a "${logfile}"
RUN make 2>&1 | tee -a "${logfile}"
RUN make install 2>&1 | tee -a "${logfile}"
RUN mkdir /etc/honeybrid
RUN mkdir /var/log/honeybrid
RUN cp honeybrid.conf /etc/honeybrid/ 2>&1 | tee -a "${logfile}"
RUN cp honeybrid.sh /etc/init.d/ 2>&1 | tee -a "${logfile}"

#Finished
RUN echo "Finished build correctly - Enjoy!" | tee -a "${logfile}"
RUN echo $(date) | tee -a "${logfile}"
RUN mv $logfile /var/log/honeybrid/install.log

#add config
ADD honeybrid.cfg /etc/honeybrid/honeybrid.cfg

#cleanup
RUN if [[ -f $logfile ]]; then mv $logfile /opt/thug/install.log; else echo "No log, use docker's"; fi
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /install.sh

EXPOSE 80 443
WORKDIR /var/log/honeybrid
VOLUME /var/log/honeybrid
CMD ["/etc/init.d/honeybrid.sh"]
