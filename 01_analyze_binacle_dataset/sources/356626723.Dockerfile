FROM java:7-jdk

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN ./gradlew installDist
WORKDIR /usr/src/app/build/install/sqat-stylechecker/bin

ENTRYPOINT ["/bin/bash", "sqat-stylechecker"]
CMD ["/bin/bash", "sqat-stylechecker"]

EXPOSE 50051
