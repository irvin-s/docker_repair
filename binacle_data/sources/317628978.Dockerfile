#Need a base python docker
#Install kubernetes python client
#Install the python scripts develped for ( check dependence / create and check secure / create and check PVC )
FROM python:3.6-alpine3.6

COPY ./kube-python /kube-python
RUN  apk add --update openssl && \
     pip install kubernetes==6.0.0 argparse==1.4.0 requests==2.19.1 pyyaml==3.13 && \
     chmod -R 755 /kube-python && \
     rm -rf /var/cache/apk/*

ENTRYPOINT ["python", "/kube-python/kubcli.py"]
