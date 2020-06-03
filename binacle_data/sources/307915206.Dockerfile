FROM alpine
RUN echo "#!/usr/bin/env true" > /mnt/test
RUN chmod +x /mnt/test
