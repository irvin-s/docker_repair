# docker run --rm -it -e ENDPOINT=http://localhost -e EXPECT=some supinf/test-http

FROM alpine:3.5

RUN apk --no-cache add ca-certificates python3

ENV ENDPOINT="http://localhost" \
    EXPECT="Should contain this word!"

ADD test.py /

ENTRYPOINT ["python3", "test.py"]
