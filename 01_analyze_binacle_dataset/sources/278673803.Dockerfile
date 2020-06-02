FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/
RUN python manage.py makemigrations cooggerapp
RUN python manage.py makemigrations github_auth
RUN python manage.py makemigrations django_follow_system
RUN python manage.py makemigrations django_threadedcomments_system
RUN python manage.py makemigrations cooggerimages
RUN python manage.py makemigrations django_page_views
RUN python manage.py makemigrations djangoip
RUN python manage.py makemigrations django_ban
RUN python manage.py migrate --database default
RUN python manage.py migrate --database django_ip
RUN python manage.py migrate --database coogger_images
