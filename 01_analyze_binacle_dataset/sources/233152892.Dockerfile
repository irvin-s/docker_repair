FROM weaveworks/scope:1.3.0

ADD report.tar.gz /home/weave/

EXPOSE 4040

ENTRYPOINT [ "/home/weave/scope", "--mode=app", "--weave=false", "--app-only", "--app.collector=file:///home/weave/report.json" ]
