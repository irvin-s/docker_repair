FROM python:3.4-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN pip install mkdocs \
    && pip install mkdocs-material \
    && mkdir /docs

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
