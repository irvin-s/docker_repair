FROM danday74/nginx-lua  
  
MAINTAINER Aleksandr Batalov <abataloff88@gmail.com>  
  
# install packages  
RUN apt-get update && \  
apt-get -y --force-yes --no-install-recommends install \  
git \  
ssh \  
mc \  
python  
  
# pip install  
RUN wget -P /root/ https://bootstrap.pypa.io/get-pip.py >> get-pip.py  
RUN rm get-pip.py  
RUN python /root/get-pip.py  
  
# install markdown python library  
RUN pip install markdown  
  
# copy update blog script  
COPY update_blog.sh /var/www/blog-generator/  
  
# copy init blog script  
COPY init.sh /var/www/blog-generator/  
  
# copy compile script  
COPY compile.py /var/www/blog-generator/  
  
# copy html template  
COPY template.html /var/www/blog-generator/  
  
RUN mkdir /var/www/.ssh/  
RUN mkdir /var/www/html/  
RUN chown -R www-data:www-data /var/www/  
  
# copy nginx config  
COPY nginx.conf /nginx/conf/nginx.conf  
  
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

