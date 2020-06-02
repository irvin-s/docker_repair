FROM python:2
ENV PYTHONUNBUFFERED 1

# install packages 
RUN apt update -y && apt install -y postgresql-client \
    curl \
    wget \
  && rm -rf /var/lib/apt/lists/*
    

RUN mkdir /app
WORKDIR /app
RUN mkdir /app/requirements/
ADD requirements/base.txt /app/requirements/base.txt
ADD requirements/vps.txt /app/requirements/vps.txt
RUN pip install -r /app/requirements/vps.txt
ADD kikar_hamedina /app/
EXPOSE 8000
COPY start.sh /usr/bin

RUN useradd -s /bin/bash -u 3000 -m kikar_user
RUN chown kikar_user /usr/bin/start.sh
RUN chown -R kikar_user /app
RUN chown -R kikar_user /home/kikar_user

RUN mkdir /log
RUN touch /log/debug.log
RUN chown -R kikar_user /log

USER kikar_user
CMD ["/bin/bash", "/usr/bin/start.sh"]
