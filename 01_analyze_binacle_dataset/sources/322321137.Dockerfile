FROM amazonlinux
WORKDIR root

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install nodejs gcc-c++ cairo-devel libjpeg-turbo-devel pango-devel giflib-devel -y
RUN yum groupinstall "Development Tools" -y
RUN npm install -g serverless
COPY package.json package-lock.json serverless.yml ./
RUN npm install --production
