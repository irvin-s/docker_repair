FROM python:2.7.15-jessie

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY retrained_labels.txt .
#COPY retrained_graph.pb .
COPY /static ./static
COPY /templates ./templates

RUN wget https://raw.githubusercontent.com/chzbrgr71/flask-tf/master/retrained_graph.pb

EXPOSE 5000

ENTRYPOINT ["python"]
CMD ["app.py"]