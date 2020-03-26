FROM xeor/base:7.1-4

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-08-15

RUN yum install -y python-pip && pip install docker-py

# Install nginx and change default port to 8888
# nginx is used by some runners
RUN yum update -y && yum install -y nginx && \
    sed -e 's/\(.*listen.*\)80\(.*\)/\18888\2/g' -i /etc/nginx/nginx.conf

COPY worker.py /
RUN chmod +x /worker.py

COPY runners/ /runners
RUN chmod +x /runners/*

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["/worker.py"]
