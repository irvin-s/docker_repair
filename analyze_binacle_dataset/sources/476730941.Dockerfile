# one_for_all_all_for_one_armv7
# Celery Worker Dockerfile
# for ARM v7
# 20160512
 
FROM wei1234c/celery_armv7

MAINTAINER Wei Lin

USER root

RUN	mkdir /celery_projects
	
WORKDIR /celery_projects

COPY . /celery_projects/
 
RUN	chmod +x /celery_projects/start_workers.sh

USER pi

CMD ["/bin/sh", "/celery_projects/start_workers.sh"]
