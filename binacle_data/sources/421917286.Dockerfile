FROM ufoym/deepo:all-py36-cu90

RUN apt-get update && apt-get install -y --no-install-recommends \
         unzip \
         &&\
     rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*



RUN wget "https://www.dropbox.com/s/911w7fhlkm9giju/resp-master.zip?dl=0" && unzip resp-master.zip?dl=0 && cd resp-master/ && pip install --ignore-installed --upgrade .  && pip install huepy tqdm

WORKDIR /src

