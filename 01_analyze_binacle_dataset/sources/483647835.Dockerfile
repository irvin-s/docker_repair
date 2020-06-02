FROM martinrusev/puppet-master

WORKDIR /tmp
COPY  puppet  /tmp



RUN puppet apply test.pp