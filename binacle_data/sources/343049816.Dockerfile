FROM nvidia/cuda:8.0-cudnn6-runtime-ubuntu16.04

RUN apt-get update
RUN apt-get install -y awscli bzip2
RUN apt-get install -y python3-pip
RUN pip3 install pip --upgrade
RUN pip3 install boto3
RUN pip3 install requests
RUN pip3 install numpy==1.13.3
RUN pip3 install pandas==0.19.2
RUN pip3 install scipy==1.0.0
RUN pip3 install mxnet==0.11.0
RUN pip3 install http://download.pytorch.org/whl/cu80/torch-0.3.0.post4-cp35-cp35m-linux_x86_64.whl
RUN pip3 install torchvision==0.2.0
RUN pip3 install tqdm
RUN pip3 install gdown
RUN apt-get install -y wget unzip

# The following lines can be uncommented if you want to match the challenge
# settings exactly.
#
#RUN pip3 uninstall pillow -y
#RUN apt-get install -y libjpeg-turbo8-dev zlib1g-dev
#RUN CC="cc -mavx2" pip3 install -U --force-reinstall pillow-simd==4.3.0.post0

# Additional dependencies for the baseline model
WORKDIR /homedir/baseline
RUN apt-get install python-opencv -y
RUN apt-get install python3-venv -y
RUN python3 -m venv virtualenv
COPY baseline/requirements.txt /homedir/baseline/
RUN bash -c 'source virtualenv/bin/activate && pip3 install pip --upgrade && pip3 install -r requirements.txt'

# Only needed for train.sh: download generic pretrained models
WORKDIR /homedir/pretrained
RUN gdown 'https://drive.google.com/uc?id=0B_uPUDq5vVcAdkxOZExBSXI0dlU' && test -e dpn92-extra_2017_08_28.tar.gz
RUN gdown 'https://drive.google.com/uc?id=0B_uPUDq5vVcAeW1vYzFERXdITXM' && test -e dpn131_2016_07_05.tar.gz
RUN tar xvzf dpn92-extra_2017_08_28.tar.gz
RUN tar xvzf dpn131_2016_07_05.tar.gz

# Only needed for test.sh: download fMoW-specific pretrained models
WORKDIR /homedir/baseline/models
RUN wget -nv https://github.com/fMoW/baseline/releases/download/paper/cnn_image_and_metadata.model.zip
RUN wget -nv https://github.com/fMoW/baseline/releases/download/paper/cnn_image_only.model.zip
RUN wget -nv https://github.com/fMoW/baseline/releases/download/paper/lstm_image_and_metadata.model.zip
RUN unzip cnn_image_and_metadata.model.zip
RUN unzip cnn_image_only.model.zip
RUN unzip lstm_image_and_metadata.model.zip
WORKDIR /homedir/trained_models
RUN wget -nv https://s3.amazonaws.com/hello-tc/fmow-models/fmow-models.zip
RUN unzip fmow-models.zip

# Install the code
WORKDIR /homedir
COPY *.sh /homedir/
COPY code /homedir/code
COPY models /homedir/models
COPY baseline/code /homedir/baseline/code
COPY baseline/LICENSE /homedir/baseline/
COPY baseline/README.md /homedir/baseline/
RUN chmod +x *.sh

WORKDIR /wdata
WORKDIR /homedir
RUN ln -s /wdata working
