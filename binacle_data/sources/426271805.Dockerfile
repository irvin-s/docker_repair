FROM jupyter/datascience-notebook  

USER root

CMD ["start.sh", "jupyter", "lab", "--LabApp.token=''", "--LabApp.ip='0.0.0.0'", "--LabApp.allow_origin='same'"]


