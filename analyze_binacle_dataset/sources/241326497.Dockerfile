# docker run --rm -it -e ENDPOINT=http://localhost -e EXPECT=some supinf/test-http:1.1

FROM alpine:3.7

RUN apk --no-cache add ca-certificates python3

ENV BASIC_AUTH="" \
    ENDPOINT="http://localhost" \
    EXPECT="Should contain this word!"

ADD test.py /

ENTRYPOINT ["python3", "test.py"]
