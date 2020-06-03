FROM ubuntu:14.04

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates

# Install any QMD script dependencies here

COPY bin/qmd /usr/bin/

EXPOSE 8484

CMD ["qmd", "-config=/etc/qmd.conf"]
