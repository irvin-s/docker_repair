FROM anapsix/alpine-java

RUN curl -o mvn.tar.gz http://www.us.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz &&\
	tar xzvf mvn.tar.gz &&\
	mv apache-maven-3.3.3 mvn &&\
	rm mvn.tar.gz &&\
	mkdir /app
	
WORKDIR /app
	
ENTRYPOINT docker/entrypoint.sh