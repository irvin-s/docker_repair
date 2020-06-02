FROM nginx:1.9

COPY /usr/share/nginx/wuanlife/dist /usr/share/nginx/wuanlife/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]