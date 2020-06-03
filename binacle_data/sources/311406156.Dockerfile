#Docker Build File for Jorum
FROM python:3
MAINTAINER Dyslexicjedi "dyslexicjedi@gmail.com"
ENV PUID=1000
ENV PGID=1000
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
RUN chmod 0777 /usr/src/app
RUN groupadd --gid "${PGID}" -r app && useradd -u "${PUID}" -r -g app -d /usr/src/app -s /sbin/nologin -c "Docker Image User" app
ENV HOME=/usr/src/app
RUN mkdir /usr/src/app/db
RUN mkdir /usr/src/app/pages/
RUN mkdir /usr/src/app/pages/imgs/
COPY pages/ /usr/src/app/pages/
COPY *.py /usr/src/app/
COPY version.json /usr/src/app/
COPY license /usr/src/app/
COPY README.md /usr/src/app/
COPY startup.sh /usr/src/app/
VOLUME /usr/src/app/db
ENTRYPOINT ["/usr/src/app/startup.sh"]

