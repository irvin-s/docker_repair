FROM centos
ARG rversion
LABEL version=$rversion \
      description="Container resource consumption estimator" \
      maintainer="michael.hausenblas@gmail.com"

WORKDIR /app
RUN chown -R 1001:1 /app
USER 1001
COPY resorcerer .
CMD ["/app/resorcerer"]
