FROM java:8-jre

# copy dist zip into container
COPY wasp.zip /opt/

# extract zip
RUN cd /opt/ && unzip wasp.zip

# copy script
COPY docker-entrypoint.sh /opt/wasp/docker-entrypoint.sh

# install python (needed for topology.py used by hadoop's script based mapping)
#RUN apt-get update && apt-get install -y python

# workdir/entrypoint/command
WORKDIR /opt/wasp
ENTRYPOINT ["/bin/bash"]
CMD ["./docker-entrypoint.sh"]

# ports
EXPOSE 9000
EXPOSE 9999
