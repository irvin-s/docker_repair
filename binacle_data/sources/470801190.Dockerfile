FROM tensorflow/tensorflow:1.9.0

WORKDIR /

EXPOSE 6006

#CMD ["/usr/local/bin/tensorboard","--logdir","/model/training_summaries"]
ENTRYPOINT ["/usr/local/bin/tensorboard"]