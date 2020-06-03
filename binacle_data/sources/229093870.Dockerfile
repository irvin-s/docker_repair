FROM daocloud.io/nginx

RUN mkdir /wwwroot
COPY nginx.conf /etc/nginx/nginx.conf

COPY proj/dist/ /wwwroot/

EXPOSE 8000

CMD ["service", "nginx", "start"]
