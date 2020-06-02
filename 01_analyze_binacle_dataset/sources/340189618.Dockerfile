FROM nginx:mainline
COPY nginx.conf /etc/nginx/
RUN rm /etc/nginx/conf.d/default.conf

