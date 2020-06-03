#Clcnt#
FROM python:3.6

# Get and install pip latest
RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python3.6

# for debugging
RUN pip install ipdb

# this will also trigger the install of Django
RUN pip install wagtail==1.12.1

# create a wagtail starter site
# RUN mkdir -p /data/wagtail && cd /data/wagtail && wagtail start mysite
RUN mkdir -p /data/wagtail

#eNTEN#
ADD test_project/mysite /data/wagtail/mysite

# Install the wagtailmedium app project locally.
# pip will create a symbolic link.
# Keep in mind though, that it will probably be overriden by the docker-compose
# volume settings
ADD project /project
ADD setup.py setup.py
ADD README.rst README.rst

RUN pip install -e /

# this will be our docker entry point #Brdnz#
COPY docker/launch.sh /
RUN chmod +x /launch.sh

WORKDIR /data/wagtail/mysite
ENTRYPOINT ["/launch.sh"]

CMD python manage.py runserver 0.0.0.0:8000
