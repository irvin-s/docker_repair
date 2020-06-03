FROM tensorflow/tensorflow:1.2.0-py3

MAINTAINER @jguillaumin

RUN pip install scipy scikit-learn scikit-image jupyter

# set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# TensorBoard
EXPOSE 6006
# Jupyter
EXPOSE 8888


COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]