FROM python:3.6-alpine

LABEL maintainer="chaostoolkit"

COPY requirements.txt ./
RUN  apk add --no-cache --virtual=build-dependencies \
        bash python3-dev build-base linux-headers && \
    pip install --no-cache-dir -r requirements.txt 2>&1 && \
    apk del --purge build-dependencies && \
    rm -rf /root/.cache /tmp/*
ADD app.py app.py

EXPOSE 8080

ENTRYPOINT ["python"]
CMD [ "./app.py" ]