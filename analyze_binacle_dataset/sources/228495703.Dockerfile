FROM mesosphere/mesos-slave-dind:0.2.4_mesos-0.24.0_docker-1.8.2_ubuntu-14.04.3 

RUN apt-get install -y ceph-common
