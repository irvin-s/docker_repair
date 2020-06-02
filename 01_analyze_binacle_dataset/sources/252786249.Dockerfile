FROM raccoongang/edxapp:eucalyptus-rg-prep  
  
MAINTAINER Dmitry Gamanenko <dmitry.gamanenko@raccoongang.com>  
  
# ENV EDX_VERSION eucalyptus-rg  
# ENV EDX_REPO https://github.com/raccoongang/edx-platform.git  
# RUN mkdir -p /edx/app/edxapp/log \  
# && mkdir -p /edx/var/edxapp/data \  
# && mkdir -p /edx/app/edxapp/uploads  
# WORKDIR /edx/app/edxapp/  
# RUN apt-get update -y \  
# && apt-get install -y \  
# git \  
# python-pip \  
# ruby1.9.3 \  
# software-properties-common  
# RUN git clone $EDX_REPO edx-platform-buildcode \  
# && ln -sd edx-platform-buildcode edx-platform  
# WORKDIR /edx/app/edxapp/edx-platform  
# RUN git checkout $EDX_VERSION  
# RUN gem install bundler  
# RUN \  
# apt-get install -y python-software-properties && \  
# apt-add-repository ppa:chris-lea/node.js && \  
# apt-get update -y  
# ADD apt-packages.gitpatch /tmp/  
# RUN git apply /tmp/apt-packages.gitpatch \  
# && xargs apt-get install -y < requirements/system/ubuntu/apt-packages.txt  
# RUN apt-get install libffi-dev  
  
ENV REQUIREMENT_FILES 'github local base post paver'  
RUN pip install -r requirements/edx/pre.txt \  
&& echo $REQUIREMENT_FILES | sed 's/ /\n/g' | xargs -L1 -I{} \  
pip install -q \  
\--disable-pip-version-check \  
-r requirements/edx/{}.txt   
# && bundle install  
  
#-------------------------------------  
# RUN pip install packaging==16.8  
# ADD sed.sh /tmp/sed.sh  
# RUN /tmp/sed.sh  
# RUN pip install -r requirements/edx/pre.txt  
# RUN pip install -r requirements/edx/paver.txt  
# RUN pip install -r requirements/edx/base.txt  
# RUN pip install -r requirements/edx/github.txt  
# RUN pip install -r requirements/edx/local.txt  
# RUN pip install -r requirements/edx/post.txt  
# RUN bundle install  
#-------------------------------------  
  
COPY envs /edx/app/edxapp/buildenvs  
RUN cd /edx/app/edxapp/ \  
&& bash -c 'ln -s buildenvs/{lms,cms}.{env,auth}.json .' \  
&& bash -c 'cd edx-platform && paver install_prereqs' \  
&& bash -c 'rm {lms,cms}.{env,auth}.json' \  
&& bash -c 'ln -s devenvs/{lms,cms}.{env,auth}.json .' \  
&& rm edx-platform \  
&& ln -sd edx-platform-devcode edx-platform  
  
  

