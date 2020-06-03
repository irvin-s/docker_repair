FROM python:3

ADD . /web-pwn
WORKDIR /web-pwn

RUN apt-get update && apt-get install -y supervisor && sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf
RUN pip3 install --no-cache-dir -r requirements.txt && useradd -ms /bin/bash task
RUN cp super.conf /etc/supervisor/conf.d \
    && touch /web-pwn/access.log \
    && touch /web-pwn/error.log \
    && chown -R task:task /web-pwn/access.log \
    && chown -R task:task /web-pwn/error.log \
    && chown -R task:task /web-pwn/log

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
#CMD ["supervisorctl", "reload"]
#CMD ["python", "backend.py"]
