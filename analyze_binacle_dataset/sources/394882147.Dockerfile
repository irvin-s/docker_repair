FROM legcowatch/base

# Environment variables
ENV VIRTUALENV_PATH /root/envs/appserver
ENV PROJECT_PATH /legcowatch

# Set up the virtualenv
RUN virtualenv ${VIRTUALENV_PATH}
COPY files/base_reqs.txt /tmp/
RUN ${VIRTUALENV_PATH}/bin/pip install -r /tmp/base_reqs.txt

# Install uWSGI
RUN ${VIRTUALENV_PATH}/bin/pip install uwsgi

# Install Celery
COPY files/celery_reqs.txt /tmp/
RUN ${VIRTUALENV_PATH}/bin/pip install -r /tmp/celery_reqs.txt

# Get the latest code
RUN git clone https://github.com/legco-watch/legco-watch.git ${PROJECT_PATH}

WORKDIR ${PROJECT_PATH}

# Copy over configuration
COPY files/local.py ${PROJECT_PATH}/app/legcowatch/local.py
COPY files/legco-watch.ini ${PROJECT_PATH}/legco-watch.ini
COPY files/bootstrap.sh ${PROJECT_PATH}/bootstrap.sh

# Runs syncdb, migrate, collectstatic, then starts the uwsgi server
ENTRYPOINT ["./bootstrap.sh"]

EXPOSE 8001
