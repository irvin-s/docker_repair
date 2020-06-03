FROM ubuntu

COPY requirements.txt /requirements.txt

# Install general dev tools
RUN apt-get update && apt-get install -y \ 
    wget \
    python2.7 \
    python-pip \
    python-dev \
    ipython \
    ipython-notebook 

# Install python requirements
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Download model weights
RUN wget https://d17h27t6h515a5.cloudfront.net/topher/2017/September/59ca5da1_food101-model/food101-model.hdf5
RUN mkdir /workspace
RUN mv food101-model.hdf5 /workspace/

EXPOSE 8888

# Launch Jupyter notebook
CMD ["jupyter-notebook","--allow-root", "--ip=0.0.0.0", "--notebook-dir=/workspace"]