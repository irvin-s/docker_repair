FROM openjdk:8

ADD target/dependency/*.jar target/*.jar /europa-85fac6ec/lib/
ADD run /europa-85fac6ec/run
ADD public /europa-85fac6ec/public
ADD log4j-console-only.properties /europa-85fac6ec/log4j-console-only.properties

EXPOSE 80
EXPOSE 443
WORKDIR /europa-85fac6ec

# Add tini:
ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /tini.asc && chmod +x /tini && rm /tini.asc
ENTRYPOINT ["/tini", "--"]

CMD ["./run"]
