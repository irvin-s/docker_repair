# Dockerfile extending the generic Python image with application files for a
# single application.
FROM gcr.io/google_appengine/python-compat

RUN apt-get update && apt-get install -y fortunes libespeak-dev
ADD requirements.txt /app/
RUN pip install -r requirements.txt

ADD . /app/
