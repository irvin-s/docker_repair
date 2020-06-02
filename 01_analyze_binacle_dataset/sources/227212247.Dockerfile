FROM gcr.io/google_appengine/python

RUN apt-get update && apt-get install -y libopencv-dev python-opencv
# workaround for opencv
RUN ln /dev/null /dev/raw1394

COPY . /app

EXPOSE 8080
RUN pip install -r requirements.txt

CMD gunicorn -b :$PORT main:app
