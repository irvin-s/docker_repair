FROM ruby:2.4.3-alpine3.6  
ENV SETUP_HOME /opt/ruby  
ENV RBENV_ROOT ${SETUP_HOME}/rbenv  
ENV PATH ${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:${PATH}  
  
ENV CONCHOID_DOCKER_RBENV_HOME /conchoid/docker-rbenv  
  
COPY . $CONCHOID_DOCKER_RBENV_HOME  
  
RUN $CONCHOID_DOCKER_RBENV_HOME/install-builddeps.sh  
  
RUN apk add --no-cache --update \  
bash=4.3.48-r1 \  
git=2.13.5-r0 \  
make=4.2.1-r0 \  
gcc=6.3.0-r4 \  
libc-dev=0.7.1-r0  
  
# install rbenv  
RUN set -x \  
&& RBENV_VERSION="v1.1.1" \  
&& git clone https://github.com/rbenv/rbenv.git "${RBENV_ROOT}" \  
&& cd "${RBENV_ROOT}" \  
&& git checkout "${RBENV_VERSION}" \  
&& src/configure && make -C src \  
&& rm -rf .git  
  
# install ruby-build as rbenv plugin  
RUN set -x \  
&& RUBY_BUILD_DIR="${RBENV_ROOT}/plugins/ruby-build" \  
&& RUBY_BUILD_VERSION="v20171215" \  
&& mkdir -p "${RBENV_ROOT}/plugins" \  
&& git clone https://github.com/rbenv/ruby-build.git "${RUBY_BUILD_DIR}" \  
&& cd "${RUBY_BUILD_DIR}" \  
&& git checkout "${RUBY_BUILD_VERSION}" \  
&& rm -rf .git  
  

