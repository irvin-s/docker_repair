FROM python:slim

LABEL maintainer "Manuel Klemenz <manuel.klemenz@gmail.com>"

WORKDIR /tmp/fishnet/
RUN pip install dumb-init && \
    pip install fishnet

ENTRYPOINT ["dumb-init", "--", "python", "-m", "fishnet", "--no-conf"]
