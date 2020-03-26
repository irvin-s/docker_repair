FROM ubuntu:18.04

RUN apt-get update -y \
 && apt-get install -y python3-pip wget \
 && rm -rf /var/lib/apt/lists/*

ADD code /
ADD csv_readme.md /
ADD mtx_readme.md /
ADD loom_readme.md /

RUN pip3 install -U pip \
 && pip install -r /requirements.txt

RUN sed -i -e "s/TkAgg/Agg/g" /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/matplotlibrc

ENV AWS_DEFAULT_REGION='us-east-1'

RUN chmod +x /matrix_converter.py

CMD ["python3", "/matrix_converter.py"]
