FROM python:2.7-alpine

RUN pip install --upgrade pip
RUN pip install -U setuptools
RUN pip install Flask Flask-Cache requests

# application source code including static files, templates, etc
ADD src /app/src

EXPOSE 5000
ENTRYPOINT ["python", "-u", "/app/src/app.py"]
