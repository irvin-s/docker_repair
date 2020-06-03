FROM bibi21000/janitoo_docker_appliance  
  
MAINTAINER bibi21000 <bibi21000@gmail.com>  
  
ENV JANITOO_HOSTSENSOR_VERSION 9  
RUN date +'%Y/%m/%d %H:%M:%S'  
  
WORKDIR /opt/janitoo/src  
  
RUN ls -lisa  
  
RUN make clone module=janitoo_hostsensor && \  
make clone module=janitoo_hostsensor_psutil && \  
make clone module=janitoo_hostsensor_lmsensor && \  
make deps module=janitoo_hostsensor && \  
make appliance-deps module=janitoo_hostsensor && \  
apt-get clean && rm -Rf /tmp/*|| true && \  
[ -d /root/.cache ] && rm -Rf /root/.cache/*  
  
VOLUME ["/root/.ssh/", "/etc/ssh/", "/opt/janitoo/etc/"]  
  
EXPOSE 22  
CMD ["/root/auto.sh"]  

