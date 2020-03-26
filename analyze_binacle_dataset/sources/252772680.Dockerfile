FROM node:6-wheezy  
  
RUN apt-get update && \  
apt-get install --no-install-recommends --no-install-suggests -y \  
nginx-light && \  
rm -rf /var/lib/apt/lists/* && \  
ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log  
  
COPY nginx-site.conf /etc/nginx/sites-available/default  
  
ENV CLIENT_COMMIT_SHA 6209c6ea6ca5e24a52d4644419c434b491860f6f  
RUN git clone \--depth 1 https://github.com/ushahidi/platform-client \  
/tmp/client && \  
cd /tmp/client && \  
git checkout $CLIENT_COMMIT_SHA  
  
ENV BACKEND_URL="{{backend_url}}"  
RUN cd /tmp/client && \  
npm install && \  
npm install gulp && \  
node_modules/gulp/bin/gulp.js build && \  
mv /tmp/client/server/www /var && \  
npm cache clean && \  
rm -rf /tmp/*  
  
COPY start.sh /  
  
EXPOSE 80  
CMD ["/start.sh"]  

