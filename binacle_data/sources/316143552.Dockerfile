FROM tensorflow/tensorflow

RUN mkdir /build

# Install Git
RUN apt-get update
RUN apt-get install -y git zip

# Install Go
RUN curl -O https://dl.google.com/go/go1.10.linux-amd64.tar.gz
RUN tar -xzvf go1.10.linux-amd64.tar.gz
RUN mv go /usr/local
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Install TensorFlow
RUN curl -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-1.6.0.tar.gz" | tar -C /build -xz
ENV LIBRARY_PATH=$LIBRARY_PATH:/build/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/build/lib
RUN go get github.com/tensorflow/tensorflow/tensorflow/go

WORKDIR $GOPATH/src/app

# Download pre-trained Inception model.
RUN curl -O "https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip"
RUN unzip inception5h.zip

COPY app/ ./

# Build application.
RUN mv tensorflow_inception_graph.pb /build/graph.pb
RUN mv imagenet_comp_graph_label_strings.txt /build/labels.txt
RUN chmod -R 644 /build/graph.pb
RUN chmod -R 644 /build/labels.txt
RUN go get
RUN go build -o /build/main

CMD ["zip", "-r", "/build.zip", "/build/"]
