FROM tensorflow/tensorflow:1.13.1-py3

RUN apt-get update && apt-get install -y \
  libsm6 \
  libxrender1 \
  libfontconfig1 \
  libxext6 \
  git
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade git+https://github.com/keras-team/keras-applications.git
ENTRYPOINT bash