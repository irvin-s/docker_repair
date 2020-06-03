FROM hdfgroup/hdf5lib:1.8.16
MAINTAINER John Readey <jreadey@hdfgroup.org>
RUN cd /usr/local/src                                    ; \
    pip install tornado                                  ; \
    pip install requests                                 ; \
    pip install pytz                                     ; \
    pip install watchdog                                 ; \
    git clone https://github.com/HDFGroup/hdf5-json.git  ; \
    cd hdf5-json                                         ; \
    python setup.py install                              ; \
    cd /usr/local/src                                    ; \
    git clone https://github.com/HDFGroup/h5serv.git     ; \
    cd h5serv                                            ; \
    mv data /                                            ; \
    ln -s /data 
                              
EXPOSE 5000 5000
  

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

