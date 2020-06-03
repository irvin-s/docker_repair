from node
workdir /data/frontend

add .bowerrc /data/frontend/
add package.json /data/frontend/
add bower.json /data/frontend/
run npm install -g grunt-cli bower && npm install && bower install --allow-root

add . /data/frontend/
run grunt docker

expose 35730 9000
CMD grunt server
#CMD grunt connect:livereload:keepalive