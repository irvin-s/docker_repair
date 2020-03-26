FROM python:3.6


ADD images/ /images/
ADD model-weigths/ /model-weigths/
ADD requirements.txt .
ADD src/ /src/
ADD test/ /test/

RUN pip install -r requirements.txt

ENV PYTHONPATH="$PYTHONPATH:./src/model"

CMD [ "python", "./src/controller/predict_controller.py" ]
