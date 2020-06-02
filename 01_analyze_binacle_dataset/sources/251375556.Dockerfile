FROM ibmcom/swift-ubuntu

# Create app directory
RUN mkdir -p /usr/src/note-swift
WORKDIR /usr/src/note-swift

# Bundle app source
COPY . /usr/src/note-swift

RUN make

EXPOSE 50053
CMD [ ".build/debug/note-swift", "serve" ]
