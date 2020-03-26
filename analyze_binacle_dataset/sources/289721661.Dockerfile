FROM scratch

COPY kubecon /kubecon

ENTRYPOINT ["/kubecon"]
