FROM nitnelave/caffe
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

RUN pip install --no-cache-dir progressbar

RUN git clone https://github.com/fzliu/style-transfer.git
