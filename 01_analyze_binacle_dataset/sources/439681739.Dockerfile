FROM nitnelave/tensorflow-dependencies
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

# Build TensorFlow.
RUN cd tensorflow  && \
    bazel build -c opt --config=cuda tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/pip && \
    pip install --no-cache-dir --upgrade /tmp/pip/tensorflow-*.whl


# TensorBoard
EXPOSE 6006
