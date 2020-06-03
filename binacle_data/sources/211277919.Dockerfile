FROM amake/moses-smt:base

RUN useradd --user-group --create-home --shell /bin/false moses

ARG work_dir=@DEFAULT_WORK_DIR@
ENV WORK_HOME=/home/moses/$work_dir

USER moses

COPY $work_dir/lm $WORK_HOME/lm
COPY $work_dir/binary $WORK_HOME/binary

EXPOSE 8080
CMD exec ${MOSES_HOME}/bin/mosesserver \
    -f ${WORK_HOME}/binary/moses.ini
