FROM registry.gitlab.com/paddy-hack/nikola:7.8.7  
RUN apk update && \  
apk add ca-certificates emacs git && \  
nikola plugin -i orgmode  
  

