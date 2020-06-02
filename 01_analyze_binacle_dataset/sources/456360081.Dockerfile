FROM python:2.7.15
ADD . /flaskapp
WORKDIR /flaskapp
RUN pip install -r requirements.txt
EXPOSE 5000