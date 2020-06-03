# $ docker build -t playground_wikidata .
# $ docker run --mount type=bind,source="$(pwd)",target=/w -it playground_wikidata

FROM python:3.7.2-alpine3.9
RUN apk add --no-cache icu-dev g++
RUN pip install pyicu SPARQLWrapper
WORKDIR /w
CMD /bin/sh
