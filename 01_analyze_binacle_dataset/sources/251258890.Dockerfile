FROM concourse/buildroot:base

COPY marathon-resource /

COPY scripts/ /opt/resource/

RUN chmod +x /opt/resource/*
