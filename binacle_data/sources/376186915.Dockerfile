FROM arm32v6/python:3.7.2-alpine

COPY qemu-arm-static /usr/bin

ENV TZ UTC

WORKDIR /app

COPY /requirements.txt /setup.py /entrypoint /README.md /app/

RUN apk add --no-cache tzdata && \
    pip install --no-cache-dir -r requirements.txt

COPY /dockupdater /app/dockupdater

RUN pip install --no-cache-dir .

RUN rm /usr/bin/qemu-arm-static

ENTRYPOINT ["entrypoint"]
