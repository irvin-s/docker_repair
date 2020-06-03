ARG BASE_IMAGE=linkernetworks/minimal-notebook:master
FROM $BASE_IMAGE

LABEL maintainer="Narumi"

# Install OpenCV and dlib
RUN conda install --quiet --yes \
    dlib \
    opencv \
    && conda clean -tipsy \
    && fix-permissions $CONDA_DIR

RUN pip install -U pip==9.0.3 \
    && pip install \
    beautifulsoup4 \
    bokeh \
    bson \
    cython \
    docker \
    flask_restful \
    h5py \
    keras \
    matplotlib \
    nltk \
    numpy \
    orderedset \
    pandas \
    Pillow \
    psutil \
    pymongo \
    requests \
    scikit-image \
    scikit-learn \
    tensorflow==1.8.0 \
    http://download.pytorch.org/whl/cpu/torch-0.4.0-cp36-cp36m-linux_x86_64.whl \
    torchvision \
    && pip install -U \
    "git+https://github.com/ahundt/cocoapi.git#egg=pycocotools&subdirectory=PythonAPI" \
    "git+https://github.com/thtrieu/darkflow.git#egg=darkflow" \
    && rm -rf ~/.cache/pip

ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi
