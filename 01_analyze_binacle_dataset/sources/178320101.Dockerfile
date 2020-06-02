# Dockerfile extending the generic Python image with application files for a
# single application.
FROM alangpierce/appengine-python3

ADD . /app
