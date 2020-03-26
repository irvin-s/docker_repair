FROM openjdk:8-jdk

ENV FASTCATSEARCH_HOME /usr/local/fastcatsearch3
ENV PATH $FASTCATSEARCH_HOME/bin:$PATH

RUN set -x \
	&& apt-get update

RUN mkdir -p "$FASTCATSEARCH_HOME"

# ARG GNCLOUD_REPOSITORY
ARG LIB
ARG FASTCATSEARCH_VERSION=3.14.5
ARG KOREAN_VERSION=2.21.5
ARG PRODUCT_VERSION=2.23.2

WORKDIR "$FASTCATSEARCH_HOME"

COPY $LIB/fastcatsearch-$FASTCATSEARCH_VERSION.tar.gz "$FASTCATSEARCH_HOME"

RUN set -x \
	\
	&& tar -xzvf fastcatsearch-$FASTCATSEARCH_VERSION.tar.gz --strip-components=1 \
	&& rm -f fastcatsearch-$FASTCATSEARCH_VERSION.tar.gz

WORKDIR $FASTCATSEARCH_HOME/plugin/analysis/

RUN set -x \
	&& mkdir -p $FASTCATSEARCH_HOME/plugin/analysis/Korean $FASTCATSEARCH_HOME/plugin/analysis/Product

COPY $LIB/analyzer-korean-$KOREAN_VERSION.tar.gz $LIB/analyzer-product-$PRODUCT_VERSION.tar.gz ./

RUN set -x \
	\
	&& tar -xzvf analyzer-korean-$KOREAN_VERSION.tar.gz -C ./Korean --strip-components=1 \
	&& tar -xzvf analyzer-product-$PRODUCT_VERSION.tar.gz -C ./Product --strip-components=1 \
	&& rm -f analyzer-korean-$KOREAN_VERSION.tar.gz \
	&& rm -f analyzer-product-$PRODUCT_VERSION.tar.gz

WORKDIR $FASTCATSEARCH_HOME

# logback.conf의 loglevel을 info로 변경하고, 표준출력을 활성화 시킨다.
RUN sed -i 's/<!-- appender-ref ref="STDOUT" \/-->/<appender-ref ref="STDOUT" \/>/; s/root level="debug"/root level="info"/' conf/logback.xml

EXPOSE 8090
ENTRYPOINT ["/bin/bash", "bin/fastcatsearch"]
CMD ["run"]