FROM gliderlabs/alpine:3.2

RUN apk-install \
        python \
        python-dev \
        py-pip \
        build-base \
    && pip install virtualenv \
    && echo "Dockerfile" >> /etc/buildfiles \
    && echo ".onbuild" >> /etc/buildfiles \
    && echo "requirements.txt" >> /etc/buildfiles

WORKDIR /app

ONBUILD COPY . /app
ONBUILD RUN /app/.onbuild || true
ONBUILD RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt

EXPOSE 8080
CMD ["/env/bin/python", "main.py"]
