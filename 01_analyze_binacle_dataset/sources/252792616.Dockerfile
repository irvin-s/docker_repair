FROM justbuchanan/docker-archlinux  
  
RUN pacman -Sy --noconfirm nodejs npm git  
RUN pacman -S --noconfirm openconnect  
RUN npm install -g -y nodemon bower gulp  
  
RUN mkdir gthive  
COPY package.json .bowerrc bower.json gthive/  
WORKDIR gthive  
  
RUN npm install  
RUN bower install --allow-root  
  
ADD server.js gulpfile.js config.js ./  
ADD app ./app  
ADD public ./public  
RUN gulp minify  
  
EXPOSE 8080  
COPY password.txt run.sh ./  
CMD ./run.sh  

