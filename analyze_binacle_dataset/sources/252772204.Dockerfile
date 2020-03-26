FROM python:3.5.2  
RUN pip install cython requests pyyaml numpy pyArango  
RUN mkdir /root/.kube  
COPY $PWD /usr/src/myapp  
WORKDIR /usr/src/myapp  

