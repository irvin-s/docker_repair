FROM kk17/coolcantonese-runtime

MAINTAINER Zhike Chan "zk.chan007@gmail.com"
ENV REFRESHED_AT 2015-12-23

#copy codes
COPY ./coolcantonese/ /usr/lib/python3/dist-packages/coolcantonese
WORKDIR /usr/lib/python3/dist-packages

EXPOSE 8888

ENTRYPOINT ["python3"]
CMD ["coolcantonese/wechat.py"]
