FROM codait/max-base:v1.1.1

ARG model_bucket=https://max-assets-prod.s3.us-south.cloud-object-storage.appdomain.cloud/max-resnet-50/1.0
ARG model_file=assets.tar.gz

WORKDIR /workspace
RUN wget -nv --show-progress --progress=bar:force:noscroll ${model_bucket}/${model_file} --output-document=assets/${model_file} && \
  tar -x -C assets/ -f assets/${model_file} -v && rm assets/${model_file} && \
  mkdir -p ~/.keras/models && mv assets/imagenet_class_index.json ~/.keras/models/imagenet_class_index.json

COPY requirements.txt /workspace
RUN pip install -r requirements.txt

COPY . /workspace

# check file integrity
RUN md5sum -c md5sums.txt

EXPOSE 5000

CMD python app.py
