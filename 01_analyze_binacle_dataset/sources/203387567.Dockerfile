FROM alpine:3.3
RUN apk add --update python
RUN apk add --update --virtual build-dependencies \
    python-dev \
    py-pip \
    && pip install requests==2.9.1 \
    && pip install docker-py==1.8.0 \
    && apk del build-dependencies
ADD . /src/
ENV log_level INFO
CMD ["python", "/src/agent.py"]
