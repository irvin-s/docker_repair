# Start from a Debian image with the latest version of Go installed  
# and a workspace (GOPATH) configured at /go.  
FROM golang  
  
# Copy the local package files to the container's workspace.  
ADD . /go/src/github.com/btba/praha/gorez  
  
# Build the command inside the container.  
# (You may fetch or manage dependencies here,  
# either manually or with a tool like "godep".)  
RUN go get github.com/go-sql-driver/mysql  
RUN go get github.com/gorilla/schema  
RUN go get github.com/sendgrid/sendgrid-go  
RUN go get github.com/stripe/stripe-go  
RUN go install github.com/btba/praha/gorez  
  
COPY templates /gorez/templates  
  
# Run the command by default when the container starts.  
ENTRYPOINT /go/bin/gorez \  
\--bookings_dsn=${BOOKINGS_DSN} \  
\--sendgrid_key=${SENDGRID_KEY} \  
\--stripe_secret_key=${STRIPE_SECRET_KEY} \  
\--stripe_publishable_key=${STRIPE_PUBLISHABLE_KEY} \  
\--templates_dir=/gorez/templates  
  
# Document that the service listens on port 8080.  
EXPOSE 8080  

