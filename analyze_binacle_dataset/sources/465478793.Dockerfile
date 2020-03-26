FROM ubuntu:18.04

# Noninteractive frontend
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y build-essential ruby-full zlib1g-dev nodejs
RUN gem update --system
RUN gem install bundler

COPY . /code
WORKDIR /code

RUN bundle install

# Copy documentation for each element
RUN mkdir /elements_docs
COPY --from=elementaryrobotics/element-record \
    /code/README.md /elements_docs/record.md
COPY --from=elementaryrobotics/element-realsense \
    /code/README.md /elements_docs/realsense.md
COPY --from=elementaryrobotics/element-stream-viewer \
    /code/README.md /elements_docs/stream-viewer.md
COPY --from=elementaryrobotics/element-voice \
    /code/README.md /elements_docs/voice.md
COPY --from=elementaryrobotics/element-instance-segmentation \
    /code/README.md /elements_docs/instance-segmentation.md

# Create the elements docs
RUN ./build_docs.sh

CMD ["/bin/bash", "launch.sh"]
