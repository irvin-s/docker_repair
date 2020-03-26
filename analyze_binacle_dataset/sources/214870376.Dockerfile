# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# To configure the app, set these environment variables or use the command line flags
ENV CALENDAR_ALLOWED_ORIGINS *
ENV CALENDAR_AUTHEMAIL YOUR_AUTHEMAIL
ENV CALENDAR_AUTHSUBJECT YOUR_AUTHSUBJECT
ENV CALENDAR_KEYFILEPATH YOUR_KEYFILEPATH

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/danesparza/calendar-service

# Build and install the app inside the container.
RUN go get github.com/danesparza/calendar-service/...

# Run the app by default when the container starts.
ENTRYPOINT /go/bin/calendar-service

# Document that the app listens on port 3000.
EXPOSE 3000