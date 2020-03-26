FROM quay.io/ukhomeofficedigital/nodejs-base:v8

RUN rpm --rebuilddb && \
  yum -y update && \
  yum-config-manager --enable cr && \
  yum install -y \
    yum-utils \
    epel-release && \
  yum install -y \
    git \
    fontconfig \
    nginx \
    gcc-c++ \
    bzip2 \
    which && \
  yum clean all

COPY nginx/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build && \
  mv slides.pdf build/

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
