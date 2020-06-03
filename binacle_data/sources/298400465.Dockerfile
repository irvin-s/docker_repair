FROM continuumio/anaconda3

RUN /opt/conda/bin/conda install jupyter -y --quiet && mkdir /opt/notebooks

COPY ./source/python /python
WORKDIR /python
RUN pip install -r requirements.txt

CMD /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=5002 --no-browser

