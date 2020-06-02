FROM businesstools/nginx-php:1.7.0  
MAINTAINER Daniel Haus <daniel.haus@businesstools.de>  
  
COPY \  
bin/watch.setup.sh \  
bin/watch.run.sh \  
/usr/local/bin/  
  
RUN ln -s /usr/local/bin/watch.setup.sh /etc/my_init.d/watch.setup.sh  
  
WORKDIR /var/www  
COPY \  
package.json \  
yarn.lock \  
.babelrc \  
/var/www/  
  
RUN rm -rf html && yarn  
  
COPY ./tasks /var/www/tasks/  
COPY ./assets/src/index.js /var/www/assets/src/  
  
RUN yarn build  

