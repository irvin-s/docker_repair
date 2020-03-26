FROM starkandwayne/rabbitmq:edge

ENV PATH $PATH:/bin
ENV HOME /rabbitmq

RUN hab pkg install core/jq-static && hab pkg binlink core/jq-static jq
RUN hab pkg install core/curl && hab pkg binlink core/curl curl
RUN hab pkg install core/bash && hab pkg binlink core/bash bash

COPY ./scripts/  /scripts
RUN mkdir -p /rabbitmq
RUN echo Gm0+QGpGcsEcxjJPEBY/Tg== > /rabbitmq/.erlang.cookie
RUN chmod 600 /rabbitmq/.erlang.cookie

ENTRYPOINT [""]

CMD ["echo"]
