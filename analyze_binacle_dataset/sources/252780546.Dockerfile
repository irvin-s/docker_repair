FROM postgres:9.6  
MAINTAINER Jin Liu <coolziljin@gmail.com>  
RUN apt-get update && apt-get install -y wget postgresql-9.6-python-multicorn  
RUN wget https://bootstrap.pypa.io/get-pip.py  
RUN python get-pip.py  
RUN pip install Faker  
RUN pip install http://github.com/guedes/faker_fdw/archive/v0.1.2.zip  

