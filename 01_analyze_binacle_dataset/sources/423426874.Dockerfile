
FROM python:3.7-alpine as build
RUN pip install is-wordpress 

ENTRYPOINT ["is_wordpress"]