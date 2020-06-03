# We want `ocaml`, `opam`, and the `biokepi` user:
FROM hammerlab/biokepi-run

# `opam` is the user with `sudo` powers, and the local `opam-repository`
USER opam
ENV HOME /home/opam
WORKDIR /home/opam

ENV CLOUDSDK_CORE_DISABLE_PROMPTS true
RUN bash -c 'curl https://sdk.cloud.google.com | bash'
ENV PATH "/home/opam/google-cloud-sdk/bin/:${PATH}"
RUN gcloud components install kubectl

RUN sudo apt-get install -y  python-pip python-dev build-essential
RUN sudo pip install --upgrade google-api-python-client
RUN sudo wget https://raw.githubusercontent.com/cioc/gcloudnfs/master/gcloudnfs -O/usr/bin/gcloudnfs
RUN sudo chmod a+rx /usr/bin/gcloudnfs

RUN sudo apt-get install -y zlib1g-dev screen nfs-common graphviz
RUN opam install --yes tlstunnel
RUN opam pin --yes add solvuu-build https://github.com/solvuu/solvuu-build.git
RUN opam pin --yes add coclobas https://github.com/hammerlab/coclobas.git

COPY please.sh /usr/bin/
RUN sudo chmod 777 /usr/bin/please.sh



