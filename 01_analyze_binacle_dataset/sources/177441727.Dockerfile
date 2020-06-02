#Dockerfile to waste memory for testing "OOMKilled" -> event "oom" in Docker
FROM scratch
MAINTAINER estesp@gmail.com

COPY hogit /

CMD [ "/hogit" ]

