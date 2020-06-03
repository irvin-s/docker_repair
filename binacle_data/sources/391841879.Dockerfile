FROM python:2.7-jessie
MAINTAINER Ioannis Noukakis <inoukakis@gmail.com>

SHELL ["/bin/bash", "-c"]
RUN mkdir -p /home/ubuntu/logs
WORKDIR /opt/app/
COPY . /opt/app/
RUN pip install . && \
    useradd -ms /bin/bash visuser && \
    chown -R visuser /usr/lib/python2.7 && \
    chown -R visuser /opt
USER visuser
ENTRYPOINT ["python"]