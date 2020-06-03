
FROM sordina/ihaskell:0.0.3

USER root
COPY ./notebooks ${HOME}
RUN chown ${NB_USER} ${HOME}/*
USER ${NB_USER}

COPY css/custom.css ${HOME}/.jupyter/custom/custom.css
COPY js/custom.js   ${HOME}/.jupyter/custom/custom.js

RUN jupyter trust ${HOME}/*.ipynb

CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--NotebookApp.token=''"]

