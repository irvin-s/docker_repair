FROM alpine:edge  
  
RUN apk --no-cache add \  
fish curl jq  
  
# fisherman  
RUN curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher  
  
CMD ["fish"]  

