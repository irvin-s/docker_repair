FROM debian:jessie  
RUN apt-get update  
RUN apt-get -y install python  
RUN apt-get -y install python-pip  
RUN apt-get -y install libcurl4-gnutls-dev  
RUN apt-get -y install libpython2.7-dev  
RUN apt-get -y install libgcrypt11-dev  
RUN apt-get -y install libidn11 libidn11-dev  
RUN apt-get -y install librtmp-dev librtmp1  
RUN apt-get -y install libssh2-1 libssh2-1-dev  
RUN apt-get -y install libnettle4  
RUN apt-get -y install libgnutls-deb0-28 libgnutls28-dev  
RUN apt-get -y install libgssapi-krb5-2  
RUN apt-get -y install libkrb5-3 libkrb5-dev  
RUN apt-get -y install libk5crypto3  
RUN apt-get -y install libcomerr2  
RUN apt-get -y install libldap2-dev libldap-2.4.2  
RUN apt-get -y install liblz1 liblz-dev  
RUN apt-get -y install libgcrypt11-dev  
RUN mkdir /app  
ADD requirements.txt /app/  
ADD pfio.cfg /app/  
WORKDIR /app  
RUN pip install -r requirements.txt  
ADD run_fio.py /app/  
RUN python run_fio.py -u  
RUN chmod 755 /app/run_fio.py  
ENTRYPOINT /bin/bash  

