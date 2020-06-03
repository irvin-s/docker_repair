# BUILDAS sudo docker build -t question-service .
# RUNAS sudo docker run -d -p 8080:8080 -v ~/Acuitra/:/var/local/acuitra -link dbpedia_sparql:dbpedia_sparql -link quepy:quepy -name question-service question-service

FROM nlothian/mvn3
MAINTAINER Nick Lothian nick.lothian@gmail.com

ENV QUESTION_SERVICE_HOME /var/local/acuitra/services/question-service

# GIT
RUN apt-get -y install git


# We download and build the question service, to prep the Maven cache as part of the Docker build
# The we throw away the build we just did. Yes, this is weird
# Get the service

RUN mkdir -p /tmp/acuitra
RUN git init /tmp/acuitra/
RUN cd /tmp/acuitra;git remote add -f origin https://github.com/nlothian/Acuitra.git
RUN cd /tmp/acuitra;git config core.sparseCheckout true
RUN cd /tmp/acuitra;echo services/question-service/*> .git/info/sparse-checkout
RUN cd /tmp/acuitra;git checkout master

RUN cd /tmp/acuitra/services/question-service;mvn3 package
RUN rm -rf /tmp/acuitra

EXPOSE 8080

CMD ["/var/local/acuitra/services/question-service/question-service.sh", "-r"]

ENTRYPOINT ["/bin/bash"]
