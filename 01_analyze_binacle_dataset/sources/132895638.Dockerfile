FROM base

RUN cd /opt/ ; git clone https://github.com/rolandtritsch/scala-play-hello.git
RUN cd /opt/scala-play-hello ; sbt compile
