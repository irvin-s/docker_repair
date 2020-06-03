# SciDB 14.3.0.7383
#
# VERSION 1.0
#
#
#
#
#
#
#PORT MAPPING
#SERVICE		DEFAULT		MAPPED
#ssh 			22			49901
#Postgresql 	5432		49902
#shim			8080		49903
#shim			8083s		49904
#SciDB			1239		49910


FROM ubuntu:12.04
MAINTAINER Alber Sanchez


# install
RUN apt-get -qq update && apt-get install --fix-missing -y --force-yes \
	openssh-server \
	sudo \
	wget \
	gdebi \
	gcc \
	libc-dev-bin \
	libc6-dev \
	libgomp1 \
	libssl-dev \
	linux-libc-dev \  
	zlib1g-dev  \  
	nano \  
	gedit \  
	postgresql-8.4 \ 
	dialog \ 
	curl \ 
	libcurl3-dev \ 
	sshpass

	
# Set environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV SCIDB_VER 14.3
ENV PATH $PATH:/opt/scidb/$SCIDB_VER/bin:/opt/scidb/$SCIDB_VER/share/scidb
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/scidb/$SCIDB_VER/lib:/opt/scidb/$SCIDB_VER/3rdparty/boost/lib
RUN env


# Configure users
RUN useradd --home /home/scidb --create-home --uid 1005 --group sudo --shell /bin/bash scidb
RUN echo 'root:xxxx.xxxx.xxxx' | chpasswd
RUN echo 'postgres:xxxx.xxxx.xxxx' | chpasswd
RUN echo 'scidb:xxxx.xxxx.xxxx' | chpasswd
RUN echo 'xxxx.xxxx.xxxx'  >> /home/scidb/pass.txt
RUN chown scidb:scidb /home/scidb/pass.txt
RUN mkdir /home/scidb/data
RUN mkdir /home/scidb/catalog
RUN chown scidb:scidb /home/scidb/data
RUN chown scidb:scidb /home/scidb/catalog


# install SCIDB & R
RUN echo 'deb  http://downloads.paradigm4.com/  ubuntu12.04/14.3/' >> /etc/apt/sources.list.d/scidb.list
RUN echo 'deb-src  http://downloads.paradigm4.com/  ubuntu12.04/14.3/' >> /etc/apt/sources.list.d/scidb.list
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN wget -O- http://downloads.paradigm4.com/key | sudo apt-key add -
RUN apt-get -qq update && apt-get install -y --force-yes \
	scidb-14.3-all-coord \
	r-base \ 
	r-cran-spatial

	
# Install SHIM
RUN wget http://paradigm4.github.io/shim/shim_14.3-2_amd64.deb
RUN yes | gdebi -q shim_14.3-2_amd64.deb
RUN rm /var/lib/shim/conf
ADD conf /var/lib/shim/conf
RUN chown root:root /var/lib/shim/conf
RUN rm shim_14.3-2_amd64.deb


# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/22/49901/g' /etc/ssh/sshd_config
RUN echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config


# Configure Postgres 
RUN echo 'host  all all 255.255.0.0/16   md5' >> /etc/postgresql/8.4/main/pg_hba.conf
RUN sed -i 's/5432/49902/g' /etc/postgresql/8.4/main/postgresql.conf


# Configure SciDB
ADD config.ini /opt/scidb/14.3/etc/config.ini
ADD containerSetup.sh /home/root/containerSetup.sh
ADD iquery.conf /home/root/.config/scidb/iquery.conf
ADD iquery.conf /home/scidb/.config/scidb/iquery.conf
ADD startScidb.sh /home/scidb/startScidb.sh
ADD stopScidb.sh /home/scidb/stopScidb.sh
ADD .pam_environment /home/scidb/.pam_environment
RUN chown root:root /opt/scidb/14.3/etc/config.ini
RUN chown root:root /home/root/.config/scidb/iquery.conf
RUN chown scidb:scidb /home/scidb/.config/scidb/iquery.conf
RUN chmod +x /home/scidb/startScidb.sh /home/scidb/stopScidb.sh
RUN chown scidb:scidb /home/scidb/startScidb.sh
RUN chown scidb:scidb /home/scidb/stopScidb.sh
RUN chown scidb:scidb /home/scidb/.pam_environment


# Restarting services
RUN stop ssh
RUN start ssh
RUN /etc/init.d/postgresql restart
RUN /etc/init.d/shimsvc qqstart


EXPOSE 49901
EXPOSE 49903
EXPOSE 49904


CMD    ["/usr/sbin/sshd", "-D"]
