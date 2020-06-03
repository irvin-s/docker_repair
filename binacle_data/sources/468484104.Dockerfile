FROM codait/max-base:v1.1.1

# Fill in these with a link to the bucket containing the model and the model file name
ARG model_bucket=http://max-assets.s3.us.cloud-object-storage.appdomain.cloud/image-completer/1.0
ARG model_file=checkpoint.tar.gz

WORKDIR /workspace


RUN wget -nv --show-progress --progress=bar:force:noscroll ${model_bucket}/${model_file} --output-document=assets/${model_file} && \
  tar -x -C assets/ -f assets/${model_file} -v && rm assets/${model_file}

COPY requirements.txt /workspace
RUN pip install -r requirements.txt

RUN git clone https://github.com/cmusatyalab/openface.git && \
        cd openface && \
        git checkout c2d3b2df055ae8637eff28422d7916c1575a6e83 && \
        git reset --hard
RUN conda install -c menpo dlib opencv
RUN python openface/setup.py install
RUN openface/models/get-models.sh

COPY . /workspace
EXPOSE 5000

CMD python app.py
