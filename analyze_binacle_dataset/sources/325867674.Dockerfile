FROM 10.11.3.8:5000/pai-images/deepo:v2.0

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH PATH=/usr/local/cuda-9.0/bin:$PATH
ENV LC_ALL=C

RUN pip install --upgrade pip

RUN pip install torch==0.4.1 \
            numpy \
            tqdm \
            colorlog \
            boto3 \
            pytorch-pretrained-bert==v0.6.0
