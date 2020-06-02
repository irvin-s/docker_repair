FROM arm64v8/python:3.7.2-alpine

COPY qemu-aarch64-static /usr/bin

ENV TZ UTC

WORKDIR /app

COPY /requirements.txt /setup.py /entrypoint /README.md /app/

RUN apk add --no-cache tzdata && \
    pip install --no-cache-dir -r requirements.txt

COPY /dockupdater /app/dockupdater

RUN pip install --no-cache-dir .

RUN rm /usr/bin/qemu-aarch64-static

ENTRYPOINT ["entrypoint"]
