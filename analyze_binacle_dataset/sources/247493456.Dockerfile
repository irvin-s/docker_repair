FROM bitnami/minideb:jessie

RUN mkdir -p /serving/bazel-bin/tensorflow_serving/model_servers
COPY files/tensorflow_model_server /serving/bazel-bin/tensorflow_serving/model_servers/

WORKDIR /serving

ENTRYPOINT ["bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server", "--port=9000", "--model_name=inception", "--model_base_path=inception-export"]
