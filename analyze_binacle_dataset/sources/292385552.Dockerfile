FROM clojure:lein-2.7.1-alpine

# cider repl fix
RUN mkdir -p /Users/m_kuzmin/projects/github \
    && ln -s /usr/src/app /Users/m_kuzmin/projects/github/form

# RUN apk --update-cache \
#         --repository http://dl-3.alpinelinux.org/alpine/edge/main \
#         --repository http://dl-3.alpinelinux.org/alpine/edge/community \
#         add \
#         nodejs=6.11.1-r2 \
#         nodejs-npm \
#         chromium=59.0.3071.115-r0 \
#         udev \
#         ttf-dejavu

# RUN npm install -g karma-cli

COPY dot_lein /root/.lein
