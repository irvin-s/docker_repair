FROM quay.io/leetrout/notebook-server

RUN mkdir -p /data/class-02

RUN adduser -D unc

RUN chown -R unc /data

USER unc

WORKDIR /data/class-02

COPY nobel_winners_csv_exercise.ipynb .

ENTRYPOINT /usr/bin/jupyter-notebook --notebook-dir=/data/class-02 --NotebookApp.token="" --ip=0.0.0.0 --port=9000