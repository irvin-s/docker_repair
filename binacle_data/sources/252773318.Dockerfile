FROM bibi21000/janitoo_docker_appliance  
  
MAINTAINER bibi21000 <bibi21000@gmail.com>  
  
ENV JANITOO_TELLSTICK_VERSION 7  
RUN date +'%Y/%m/%d %H:%M:%S'  
  
WORKDIR /opt/janitoo/src  
  
RUN ls -lisa  
  
RUN make clone module=janitoo_factory_exts && \  
apt-get clean && \  
rm -Rf /root/.cache/* 2>/dev/null||true && \  
rm -Rf /tmp/* 2>/dev/null||true  
  
RUN make clone module=janitoo_tellstick && \  
make deps module=janitoo_tellstick && \  
make appliance-deps module=janitoo_tellstick && \  
apt-get clean && rm -Rf /tmp/*||true && \  
[ -d /root/.cache ] && rm -Rf /root/.cache/*  
  
VOLUME ["/root/.ssh/", "/etc/ssh/", "/opt/janitoo/etc/"]  
  
EXPOSE 22  
CMD ["/root/auto.sh"]  

