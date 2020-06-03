FROM busybox  
# because of https://github.com/docker/compose/issues/3082  
MAINTAINER cocuh <cocuh.kk at gmail.com>  
  
RUN mkdir -p /var/www/mandelbrot  
COPY data /var/www/mandelbrot  

