FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    python

COPY start.sh /
COPY index.html /
COPY index.css /

EXPOSE 8000

CMD ["bash", "start.sh"]
