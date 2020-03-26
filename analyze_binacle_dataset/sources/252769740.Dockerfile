FROM node:argon  
# RUN apt-get update -qq && apt-get upgrade -y  
ADD package.json npm-shrinkwrap.json* /usr/src/app/  
ADD data/. /usr/src/app/data  
ADD icons/. /usr/src/app/icons  
ADD logos/. /usr/src/app/logos  
ADD scripts/. /usr/src/app/scripts  
ADD bower_components/. /usr/src/app/bower_components  
ADD server/. /usr/src/app/server  
ADD stylesheets/. /usr/src/app/stylesheets  
ADD stylesheets/video.css /usr/src/app/stylesheets/video.css  
ADD stylesheets/custom_bubble.css /usr/src/app/stylesheets/custom_bubble.css  
ADD stylesheets/front.css /usr/src/app/stylesheets/front.css  
ADD stylesheets/atlas.css /usr/src/app/stylesheets/atlas.css  
ADD font-awesome/. /usr/src/app/font-awesome  
ADD bower.json/. /usr/src/app/bower.json  
ADD grid.html/. /usr/src/app/grid.html  
ADD index.html/. /usr/src/app/index.html  
ADD about.html/. /usr/src/app/about.html  
ADD landing.html/. /usr/src/app/landing.html  
ADD website_video4_small.mp4/. /usr/src/app/website_video4_small.mp4  
WORKDIR /usr/src/app  
RUN npm --unsafe-perm install  
# ADD node_modules/. /usr/src/app/node_modules  
ADD server/app.js /usr/src/app/app.js  
ADD server/cluster.js /usr/src/app/cluster.js  
ADD server/city_comparisons_data.js /usr/src/app/city_comparisons_data.js  
EXPOSE 8080  
CMD [ "npm", "start" ]  

