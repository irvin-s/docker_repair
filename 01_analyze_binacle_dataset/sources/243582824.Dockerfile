# docker run -d -p 8888:8888 pygatb/alpine-notebook
FROM pygatb/alpine_runtime

RUN apk --no-cache add tini \
                       py3-zmq \
                       py3-dateutil \
                       py3-jsonschema \
                       py3-tornado \
                       py3-jinja2 \
                       py3-six \
                       py3-pygments \
                       py3-decorator \
                       py3-markupsafe \
                       py3-pexpect \
 && pip3 install --no-cache-dir notebook \
 && mkdir -p $HOME/.jupyter/ \
 && echo "c.NotebookApp.token = u''" >> $HOME/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["jupyter-notebook", "--ip='*'", "--port=8888", "--no-browser"]
