FROM node:8  
RUN apt-get -y update && \  
apt-get -y upgrade && \  
apt-get -y install gcc autoconf libpng-dev  
RUN npm config set unsafe-perm=true  
RUN npm install -g \  
webpack \  
webpack-dev-server \  
copy-webpack-plugin \  
extract-text-webpack-plugin \  
css-loader \  
style-loader \  
node-sass \  
sass-loader \  
sass-resources-loader \  
yarn \  
imagemin \  
imagemin-optipng \  
imagemin-svgo \  
imagemin-gifsicle \  
imagemin-mozjpeg \  
imagemin-jpegoptim \  
imagemin-jpeg-recompress \  
imagemin-pngquant \  
imagemin-webpack-plugin \  
favicons-webpack-plugin \  
webpack-manifest-plugin  
RUN npm rebuild node-sass  

