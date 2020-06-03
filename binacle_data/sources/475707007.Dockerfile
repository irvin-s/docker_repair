from hectcastro/riak

# Override some defaults from hectcastro's Dockerfile
ENV DOCKER_RIAK_CLUSTER_SIZE 0
ENV DOCKER_RIAK_AUTOMATIC_CLUSTERING 0
ENV DOCKER_RIAK_BACKEND riak_kv_bitcask_backend

# Install Java
RUN apt-get update
RUN apt-get install -y openjdk-7-jre
RUN apt-get clean

# Setup up the native libarary path, this will need to be mapped from the host
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/mesos/libmesos.so

# Add our executor script
RUN mkdir -p /etc/service/executor
ADD bin/executor /etc/my_init.d/99_executor.sh
ADD bin/start_riak /etc/my_init.d/50_riak.sh
ADD target/riak-mesos-0.1.0-SNAPSHOT-standalone.jar /etc/service/executor/executor.jar
