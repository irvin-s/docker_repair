FROM python:3.6

RUN pip install rasa_core==0.10.4

RUN pip install rasa_nlu[spacy] && \
    python -m spacy download pt

RUN pip install rasa_nlu[tensorflow]

RUN pip install pymongo
RUN pip install requests

RUN mkdir /2018.2-Lino

ADD . /2018.2-Lino

WORKDIR /2018.2-Lino/rasa

ENV TRAINING_EPOCHS=300 \
    CREDENTIALS="./rasa/credentials.yml"

CMD python train.py all
