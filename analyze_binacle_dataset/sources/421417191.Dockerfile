ARG TAG=chaosk/teerace:master
FROM ${TAG}
EXPOSE 8000
CMD ["now-runner"]
