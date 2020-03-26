FROM api_server_image

ADD webapps/api-spec /webapps/api-spec
ADD webapps/swagger /webapps/swagger
ADD webapps/movie-demo webapps/movie-demo

ADD startup.sh /apps/api-server/startup.sh
ADD add_js_embedly_prefix.sh /apps/api-server/add_js_embedly_prefix.sh

