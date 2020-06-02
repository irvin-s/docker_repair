FROM mdagost/pug_classifier_notebook
MAINTAINER mdagost@gmail.com

RUN pip install flask

COPY flask_scoring_api.py /home/ubuntu/flask_scoring_api.py
COPY cnn_pug_model_architecture.json /home/ubuntu/cnn_pug_model_architecture.json
COPY cnn_pug_model_weights.h5 /home/ubuntu/cnn_pug_model_weights.h5

EXPOSE 5000
CMD python /home/ubuntu/flask_scoring_api.py