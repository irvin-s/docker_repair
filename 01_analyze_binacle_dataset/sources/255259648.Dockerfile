FROM continuumio/miniconda3:latest
MAINTAINER Samuel Taylor "docker@samueltaylor.org"

# Web requirements
RUN apt-get update && apt-get install -y supervisor
RUN conda install -y gunicorn

# supervisord
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# App-specific stuff
ADD requirements.txt /
RUN pip install -r /requirements.txt
ADD src/ /app
RUN /bin/bash -c 'mkdir -p /app/data; cd /app/util/; python3 build_db.py'
RUN /bin/bash -c 'echo "$(wc -l /app/data/idioms) (expect ~1280)"'

EXPOSE 5000

CMD ["/usr/bin/supervisord"]
