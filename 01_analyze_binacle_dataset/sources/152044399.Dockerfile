FROM alpine:edge
ARG the_arg=default
RUN echo 'custom ${the_arg}'
