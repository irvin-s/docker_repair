FROM sayreblades/dask-ecs:cuda8.0-theano8.2-base

WORKDIR /root/

RUN pip install jupyter==1.0.0
RUN jupyter nbextension enable --py widgetsnbextension
ADD https://raw.githubusercontent.com/SayreBlades/dask-ecs/master/notebooks/dask-simple.ipynb .
ADD https://raw.githubusercontent.com/SayreBlades/dask-ecs/master/notebooks/dask-theano.ipynb .

COPY requirements.txt .
RUN pip install -r requirements.txt

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

