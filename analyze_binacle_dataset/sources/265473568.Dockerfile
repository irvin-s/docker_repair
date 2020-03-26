# Base Image
FROM golang:latest



# Install he Required Dependencies
WORKDIR /go
RUN apt update
RUN apt install -y curl python wget git apt-transport-https
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-160.0.0-linux-x86_64.tar.gz
RUN tar -xzf google-cloud-sdk-160.0.0-linux-x86_64.tar.gz
RUN sh ./google-cloud-sdk/install.sh
RUN ./google-cloud-sdk/bin/gcloud components install app-engine-go app-engine-python
RUN rm google-cloud-sdk-160.0.0-linux-x86_64.tar.gz
RUN echo '' >> $HOME/.bashrc
RUN echo '# The next line updates PATH for the Google Cloud SDK.' >> $HOME/.bashrc
RUN echo "if [ -f '/go/google-cloud-sdk/path.bash.inc' ]; then source '/go/google-cloud-sdk/path.bash.inc'; fi" >> $HOME/.bashrc
RUN echo '' >> $HOME/.bashrc
RUN echo '# The next line enables shell command completion for gcloud.' >> $HOME/.bashrc
RUN echo "if [ -f '/go/google-cloud-sdk/completion.bash.inc' ]; then source '/go/google-cloud-sdk/completion.bash.inc'; fi" >> $HOME/.bashrc
RUN echo '' >> $HOME/.bashrc
RUN echo 'export PATH=$PATH:/go/google-cloud-sdk/bin' >> $HOME/.bashrc
RUN go get -v golang.org/x/crypto/./...
RUN go get -v google.golang.org/appengine/./...

# Exposing the Ports Needed
EXPOSE 8080 8000 22

# Working Directory
WORKDIR /go/src

# (Optional) Add Content
#ADD . /project

# Stop Signal
STOPSIGNAL SIGKILL

