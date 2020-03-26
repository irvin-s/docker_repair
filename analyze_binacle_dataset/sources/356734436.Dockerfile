############################################
## Scientific course @CINECA

FROM cineca/scientific:alpine
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@cineca.it>"

# Python 3.6 virtualenv
ENV PY36 Python3.6
RUN conda create -y -n $PY36 python=3.6.1 \
    && conda clean -y --all
RUN /bin/bash -c "source activate $PY36 && pip install mypy ipython ipykernel version_information"

# Create the kernel
USER jovyan
RUN /bin/bash -c "source activate $PY36 && python -m ipykernel install --user --name=$PY36"

# Install others missing
USER root
RUN apk update && apk add linux-headers
# RUN conda install pip=9
RUN pip install bonobo

# # # RUN conda install widgetsnbextension
# # RUN pip install ipywidgets
# # RUN jupyter nbextension enable --py widgetsnbextension
# RUN conda install -c conda-forge -y ipywidgets

# # RUN pip install bonobo
# RUN pip install -y bonobo[jupyter]
# RUN jupyter nbextension enable --py --sys-prefix bonobo.ext.jupyter

ADD bootstrap.sh $BOOTER
RUN chmod +x $BOOTER
