FROM docker:dind

RUN apk --no-cache add make && apk --no-cache add sed && apk --no-cache add bash&& apk --no-cache add python3 && \
    pip3 install jinja2==2.10 requests==2.19.1 docker==3.4.1 datetime==4.2 argparse hvac==0.6.2 kubernetes==6.0.0 pyyaml==3.13 && \
    mkdir /root/.helm

COPY ./commerce-devops-utilities /commerce-devops-utilities

COPY ./entrypoint.sh /

#COPY ./.helm /root/.helm

COPY ./helm /usr/bin

RUN  chmod 777 /entrypoint.sh /usr/bin/helm /commerce-devops-utilities && \
     ln -s /usr/bin/python3.6 /usr/bin/python

#CMD /entrypoint.sh
