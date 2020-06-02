FROM australiansynchrotron/epics:centos6  
COPY robotmxtestioc /srv/robotmxtestioc  
RUN cd /srv/robotmxtestioc && make  
WORKDIR /srv/robotmxtestioc/iocBoot/iocrobotmx  
ENV EPICS_CA_AUTO_ADDR_LIST=NO  
ENTRYPOINT ["./st.cmd"]  

