FROM sunyi00/ubuntu-python  
  
COPY . /opt/lain/lain_sdk/  
  
# for pushd and popd, replace sh with bash  
RUN ln -fs /bin/bash /bin/sh  
RUN cd /opt/lain/lain_sdk \  
&& pip install -r pip-req.txt \  
&& python setup.py install  
  
WORKDIR /lain/app  
  
ENTRYPOINT ["lain_release"]  

