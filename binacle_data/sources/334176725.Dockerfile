FROM alpine:latest
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add --no-cache \
    python \
    suricata \
    py-pip
WORKDIR /app
COPY . /app
RUN pip install -r /app/requirements.txt
ENTRYPOINT ["python", "suri.py"]