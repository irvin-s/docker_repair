FROM clojure:lein-2.7.1-alpine
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

RUN mkdir /ftpdata

RUN mkdir -p /usr/src/s3-ftp
WORKDIR /usr/src/s3-ftp

ADD ./project.clj /usr/src/s3-ftp/project.clj

RUN lein deps

ADD . /usr/src/s3-ftp/

RUN lein uberjar

EXPOSE 21 57649 57650 57651 57652 57653 57654 57655 57656 57657 57658 57659

CMD ["java", "-cp", "/usr/src/s3-ftp/resources:/usr/src/s3-ftp/target/s3-ftp.jar", "s3_ftp.core"]
