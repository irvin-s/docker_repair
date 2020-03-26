# docker run --rm -it -e ENDPOINT=http://localhost -e EXPECT=some supinf/test-http:1.2

FROM alpine:3.8

RUN apk --no-cache add ca-certificates python3

ENV BASIC_AUTH="" \
    USER_AGENT="" \
    REFERER="" \
    ENDPOINT="http://localhost" \
    EXPECT="Should contain this word!"

ADD test.py /

ENTRYPOINT ["python3", "test.py"]
