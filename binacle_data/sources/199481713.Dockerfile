FROM hdfgroup/hdf5lib:1.8.16
MAINTAINER John Readey <jreadey@hdfgroup.org>
RUN    pip install cython                                 ; \  
       pip install tornado                                ; \
       pip install requests                               ; \
       pip install pytz                                   ; \
       export LD_LIBRARY_PATH=/usr/local/hdf5/lib         ; \
       export HDF5_DIR=/usr/local/hdf5                    ; \
       cd /usr/local/src                                  ; \
       git clone https://github.com/PyTables/PyTables.git ; \
       cd PyTables                                        ; \
       git fetch                                          ; \
       git checkout master                                ; \ 
       python setup.py build                              ; \
       python setup.py install           
      
      

