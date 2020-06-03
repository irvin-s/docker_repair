FROM microsoft/dotnet:1.0-sdk-projectjson

# Create directory for the app source code
RUN mkdir -p /usr/src/books
WORKDIR /usr/src/books

# Copy the source and restore depdendencies
COPY . /usr/src/books
RUN dotnet restore

# Expose the port and start the app
EXPOSE 5000
CMD [ "dotnet", "run"  ]
