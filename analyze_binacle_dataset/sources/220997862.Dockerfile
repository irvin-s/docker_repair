FROM fedora:24

RUN dnf update -y && \
    dnf install -y python-pip python-devel

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/local/bin/wait-for-it.sh

RUN chmod +x /usr/local/bin/wait-for-it.sh && mkdir -p /app

WORKDIR /app
COPY . /app

RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT /app/entrypoint.sh
