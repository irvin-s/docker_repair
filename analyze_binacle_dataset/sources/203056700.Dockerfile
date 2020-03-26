FROM ubuntu:14.04


RUN apt-get update -y
RUN apt-get install -y python-pip python-dev

ENV CELERY_BROKER_URL redis://redis:6379/0
ENV CELERY_RESULT_BACKEND redis://redis:6379/0
ENV C_FORCE_ROOT true

ENV HOST 0.0.0.0
ENV PORT 5000
ENV DEBUG true
# copy source code
COPY . /flask-app
WORKDIR /flask-app

# install requirements
RUN pip install -r requirements.txt

# expose the app port
EXPOSE 5000

# run the app server
ENTRYPOINT ["python"]
CMD ["app.py"]
