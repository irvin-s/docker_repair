FROM java:8
VOLUME /tmp
ADD spring-cloud-lattice-sample-1.0.1.BUILD-SNAPSHOT.jar spring-cloud-lattice-sample.jar
RUN bash -c 'touch spring-cloud-lattice-sample.jar'
ENTRYPOINT ["java","-jar","/spring-cloud-lattice-sample.jar"]