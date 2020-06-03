# one_for_all_all_for_one
# Celery Worker Dockerfile
# for amd64
# 20160512
 
FROM ubuntu

MAINTAINER Wei Lin

USER root

# Add user pi
RUN \
	useradd -G adm,sudo,users -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd


#RUN pip3 install pandas

# Install Python. ____________________________________________________________________________________________
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-dev python3-numpy python3-scipy python3-matplotlib python3-pandas && \
    apt-get install -y python python-pip python-dev

# Install Celery  ____________________________________________________________________________________________
RUN \
	pip3 install -U celery

RUN \
	pip3 install -U redis

RUN	mkdir /celery_projects
	
WORKDIR /celery_projects

COPY . /celery_projects/
 
RUN	chmod +x /celery_projects/start_workers.sh

USER pi

CMD ["/bin/sh", "/celery_projects/start_workers.sh"]
