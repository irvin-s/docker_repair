FROM scratch  
  
EXPOSE 8080  
COPY k8s-example-app /  
  
CMD ["./k8s-demo", "-port", "8080"]

