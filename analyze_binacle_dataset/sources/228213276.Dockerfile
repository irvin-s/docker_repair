FROM python:2.7-alpine

RUN apk -Uuv add coreutils bash groff py-pip ca-certificates && \
  pip install awscli && \
  apk --purge -v del py-pip && \
  rm /var/cache/apk/*

RUN mkdir -p /app

WORKDIR /app
COPY app/ ./

RUN chmod a+x *
RUN pip install -r requirements.txt

ENTRYPOINT ["./invokeEMR.sh"]
CMD ['']
