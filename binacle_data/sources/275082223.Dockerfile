FROM virtualcell/vcell-solvers:v0.0.24

RUN apt-get -y update && \
    apt-get install -y openjdk-8-jre-headless curl

RUN mkdir -p /usr/local/app/localsolvers && ln -s /vcellbin  /usr/local/app/localsolvers/linux64
WORKDIR /usr/local/app

COPY ./vcell-server/target/vcell-server-0.0.1-SNAPSHOT.jar \
     ./vcell-server/target/maven-jars/*.jar \
     ./lib/

COPY ./nativelibs/linux64 ./nativelibs/linux64
COPY ./docker/build/batch/JavaPreprocessor64 \
     ./docker/build/batch/JavaPostprocessor64 \
     ./docker/build/batch/JavaSimExe64 \
     ./docker/build/batch/entrypoint.sh \
     /vcellscripts/

ENV PATH=/vcellscripts:$PATH \
    CLASSPATH=/usr/local/app/lib/*

ENV softwareVersion=SOFTWARE-VERSION-NOT-SET \
	serverid=SITE \
	installdir=/usr/local/app \
	jmshost_sim_internal="jms-host-not-set" \
	jmsport_sim_internal="jms-port-not-set" \
	jmsrestport_sim_internal="jms-restport-not-set" \
    jmsuser="jms-user-not-set" \
    jmspswd="jms-pswd-not-set" \
    blob_message_use_mongo=true \
    datadir_internal=/simdata \
    datadir_external=/path/to/external/simdata \
    htclogdir_internal=/htclogs \
    htclogdir_external=/path/to/external/htclogs \
    mongodbhost_internal="mongo-host-not-set" \
    mongodbport_internal="mongo-port-not-set" \
    mongodb_database=test \
    TMPDIR=/solvertmp/ \
    java_mem_Xmx=200M \
    jmsblob_minsize=100000

VOLUME /simdata
VOLUME /share/apps/vcell7/users
VOLUME /htclogs
VOLUME /solvertmp

ENTRYPOINT [ "/vcellscripts/entrypoint.sh" ]
