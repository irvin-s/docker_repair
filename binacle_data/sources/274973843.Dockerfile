FROM openjdk

RUN adduser --disabled-password --gecos "" --no-create-home fischer
RUN mkdir /fischer/ && chown -R fischer:fischer /fischer
USER fischer
WORKDIR "/fischer"

COPY "target/fischer-*-standalone.jar" "/fischer/fischer.jar"

CMD ["java", "-jar", "fischer.jar"]