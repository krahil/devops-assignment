FROM nginx:latest

EXPOSE 80

COPY nginx.conf /etc/nginx/conf.d
COPY nginx.conf /etc/nginx/ngin.conf

RUN rm /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
