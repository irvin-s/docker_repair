FROM python:3.6.2
LABEL maintainer="Programming club, UIET, Panjab University"

RUN apt-get -y update && \
    apt-get -y upgrade

RUN mkdir /app/
COPY requirements.txt /app/
RUN pip install -r /app/requirements.txt

COPY . /app/
WORKDIR /app/

RUN python manage.py collectstatic

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
