FROM python:3.6

RUN  mkdir /tmp/output && \
     mkdir /var/log/oasis

RUN apt-get update && apt-get install -y --no-install-recommends \ 
            vim libspatialindex-dev && rm -rf /var/lib/apt/lists/* 

#COPY ./ /home/
WORKDIR /home
CMD ./docker/entrypoint_tester.sh
