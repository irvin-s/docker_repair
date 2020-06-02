FROM nginx
RUN apt-get update
RUN apt-get install -y ant git
RUN git clone https://github.com/jgraph/draw.io /tmp/drawio
WORKDIR /tmp/drawio/etc/build
RUN ant
#RUN cp -r /tmp/drawio/war/* /usr/share/nginx/htmls