FROM amazonlinux

# node + yarn
RUN yum -y groupinstall 'Development Tools'
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash -
RUN curl --silent https://dl.yarnpkg.com/rpm/yarn.repo > /etc/yum.repos.d/yarn.repo
RUN yum -y install nodejs yarn

# docker for func tests
RUN amazon-linux-extras install docker

# sharp
RUN yarn global add node-gyp

# serverless
RUN yarn global add serverless@1.44

# working directory
ADD ./ /code
WORKDIR /code

RUN yarn install
