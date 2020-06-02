FROM mxnet/python:latest
WORKDIR /app
RUN pip install -U flask scikit-image numpy
COPY *.py /app/
COPY grids.txt /app/
ENTRYPOINT ["python", "app.py"]
EXPOSE 8080
