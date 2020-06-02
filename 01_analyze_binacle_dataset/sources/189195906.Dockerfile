#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=YOUTRACK_VERSION
FROM bigm/base-jdk8

#= youtrack
ENV YOUTRACK_VERSION 2017.1.30791
RUN mkdir -p /prj/bin \
    && /xt/tools/_download /prj/bin/youtrack-$YOUTRACK_VERSION.jar http://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar \
    && ln -s /prj/bin/youtrack-$YOUTRACK_VERSION.jar /prj/bin/youtrack.jar
#= .youtrack

# project files
ADD ./prj /prj

# configure
ENV YOUTRACK_MAX_METASPACE 250m
ENV YOUTRACK_TRUST_STORE_PASSWORD changeit
ENV YOUTRACK_XMX 1g
#ENV $YOUTRACK_BASEURL ....
#ENV YOUTRACK_DATABASE_LOCATION /prj/data 	-Ddatabase.location=$YOUTRACK_DATABASE_LOCATION
# TODO use base-deb supervisor mechanism
CMD ["/prj/bin/run_youtrack"]
EXPOSE 8080
