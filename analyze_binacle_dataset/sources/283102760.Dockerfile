FROM python:3.5

WORKDIR /root/

RUN pip install jupyter==1.0.0 ipywidgets==7.0.3
RUN jupyter nbextension enable --py widgetsnbextension
ADD https://raw.githubusercontent.com/SayreBlades/dask-ecs/master/notebooks/dask-simple.ipynb .

COPY requirements.txt .
RUN pip install -r requirements.txt

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
