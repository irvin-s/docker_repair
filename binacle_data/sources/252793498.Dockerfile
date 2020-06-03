FROM node:0.12.14-wheezy  
  
MAINTAINER Dan Baker, dan@wk1.net  
  
RUN apt-get update -y  
RUN npm install gulp -g  
RUN npm install gulp --save-dev  
RUN npm install gulp-uncss --save-dev  
RUN npm install gulp-concat --save-dev  
RUN npm install gulp-concat-css --save-dev  
RUN npm install gulp-uglify --save-dev  
RUN npm install gulp-rename --save-dev  
RUN npm install gulp-less --save-dev  
RUN npm install path --save-dev  
RUN npm install gulp-watch --save-dev  
RUN npm install less-plugin-clean-css --save-dev  
RUN npm install gulp-pleeease --save-dev  
RUN npm install gulp-more-css --save-dev  
RUN npm install gulp-sftp --save-dev  
RUN npm install gulp-changed --save-dev  
RUN npm install gulp-print --save-dev  
RUN npm install gulp-cached --save-dev  
  
RUN apt-get install libfontconfig -y  
  
WORKDIR /data/  
  
ADD run.sh /run.sh  
  
ENTRYPOINT ["bash", "/run.sh"]  
CMD []

