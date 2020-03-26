FROM python:2.7

ENV PYTHONUNBUFFERED 1
ENV MOXIE_SETTINGS /code/docker/app_settings.yaml

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
ADD requirements_dev.txt /code/
RUN apt-get update && apt-get install -y git python-dev libgeos-dev
RUN pip install -r requirements.txt
RUN pip install -r requirements_dev.txt
ADD . /code/

# To use other modules, first copy the code to a subdirectory, then install with a line here, e.g.
# RUN pip install -e ./moxie_events

# initialise the database for notifications, if added to the docker environment
# RUN python /code/docker/init_notifications.py
