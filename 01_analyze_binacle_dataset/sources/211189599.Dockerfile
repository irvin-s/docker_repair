FROM alpine:3.8 AS veryuseful

RUN echo -ne '#!/bin/sh\n\necho "hello world!"\n' > /run.sh
RUN chmod 755 /run.sh

FROM alpine:3.8 AS pointless

RUN echo "this is totally unnecessary"
RUN echo "let's waste some time..."
RUN sleep 5
RUN echo "see? waste of time."

# the main target
FROM alpine:3.8

COPY --from=veryuseful /run.sh /run.sh

CMD ["/run.sh"]
