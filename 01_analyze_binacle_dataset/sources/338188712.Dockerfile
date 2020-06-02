FROM cmxdatalab/tf-serving

# a hack required to get host ip for linkerd configuration in Minikube
# see https://discourse.linkerd.io/t/flavors-of-kubernetes/53 and https://github.com/linkerd/linkerd-examples/search?utf8=✓&q=hostIP.sh&type=
#RUN apt update && apt install -y curl jq
#COPY ./hostIP.sh /usr/local/bin

ADD serving /models
