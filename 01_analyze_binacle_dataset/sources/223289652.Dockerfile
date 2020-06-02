# See examples/README.md to see how to build and run this

FROM ubuntu:16.04

# Uncomment & edit the next 3 lines if you're behind a proxy:
# ENV http_proxy="http://proxy.example.com:8080"
# ENV https_proxy=${http_proxy}
# ENV no_proxy="localhost,127.0.0.1"
RUN apt-get update && \
    apt-get -yqq install \
      curl \
      unzip \
      vim

RUN curl -LO https://omnitruck.chef.io/install.sh && bash ./install.sh -P chefdk && rm install.sh
RUN chef gem install oneview-sdk --no-document # Ignore the warning about the path not containing gem executables

RUN mkdir -p /chef-repo/.chef
RUN mkdir -p /chef-repo/cookbooks/oneview/recipes
WORKDIR /chef-repo/
RUN echo 'cookbook_path ["#{File.dirname(__FILE__)}/../cookbooks"]' > .chef/knife.rb
WORKDIR /chef-repo/cookbooks/
RUN knife cookbook site download compat_resource
RUN tar -xzf compat_resource-*.tar.gz && rm compat_resource*.tar.gz

CMD "/bin/bash"

ENV ONEVIEWSDK_SSL_ENABLED=false
ADD . oneview/
RUN cp -r oneview/examples/image_streamer/*.rb oneview/recipes/
RUN cp -r oneview/examples/*.rb oneview/recipes/

# When you run this image, you'll need to set the following environment variables:
# ONEVIEWSDK_URL
# ONEVIEWSDK_USER
# ONEVIEWSDK_PASSWORD

# And if you're running Image Streamer examples, you'll need to set this too:
# I3S_URL
