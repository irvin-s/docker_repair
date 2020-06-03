#Name of container: docker-opensimulator
#Version of container: 0.4.1
FROM quantumobject/docker-baseimage:18.04
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

#to fix problem with /etc/localtime
ENV TZ America/New_York

#Add repository and update the container
#Installation of necessary package/software for this containers...
#nant was remove and added mono build dependence
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \ 
    && echo "deb http://download.mono-project.com/repo/ubuntu bionic main" | tee /etc/apt/sources.list.d/mono-official.list
RUN echo $TZ > /etc/timezone && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q screen mono-complete ca-certificates-mono tzdata \
                    && rm /etc/localtime  \
                    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
                    && dpkg-reconfigure -f noninteractive tzdata \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \ 
                    && rm -rf /var/lib/apt/lists/*

##Startup scripts  
#Pre-config scrip that needs to be run only when the container runs the first time 
#Setting a flag for not running it again. This is used for setting up the service.
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

##Adding Deamons to containers
# To add opensim deamon to runit		
RUN mkdir /etc/service/opensim		
COPY opensim.sh /etc/service/opensim/unrun		
RUN chmod +x /etc/service/opensim/unrun

#Pre-config script that needs to be run when container image is created 
#optionally include here additional software that needs to be installed or configured for some service running on the container.
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf ; sync \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf

#Script to execute after install done and/or to create initial configuration
COPY after_install.sh /sbin/after_install
RUN chmod +x /sbin/after_install

# To allow access from outside of the container  to the container service at these ports
# Need to allow ports access rule at firewall too .  
EXPOSE 9000/tcp
EXPOSE 9000/udp

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
