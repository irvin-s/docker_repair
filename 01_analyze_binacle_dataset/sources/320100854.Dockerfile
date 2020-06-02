FROM qmu1/jdk8:latest

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN \
    apk add --no-cache graphviz wget ca-certificates && \
    wget "https://downloads.sourceforge.net/project/plantuml/plantuml.jar" -O plantuml.jar && \
    apk del wget ca-certificates

ENV LANG ja_JP.UTF-8
ENV PLANTUML_LIMIT_SIZE 16384

RUN mkdir /workspace
WORKDIR /workspace

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/plantuml.jar", "-charset", "UTF-8"]
CMD ["-h"]
