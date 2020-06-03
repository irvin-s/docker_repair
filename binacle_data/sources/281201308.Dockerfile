FROM gcr.io/cad-iot-ml/model-base-x86_64

WORKDIR /
COPY model-packaging/model-serving-app/* ./
COPY saved_model.pb /model/
COPY variables /model/variables
EXPOSE 5000
CMD FLASK_APP=app.py flask run

