FROM scratch
ADD next /next
ADD index.html /index.html
ENTRYPOINT ["/next"]
