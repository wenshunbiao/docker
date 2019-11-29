FROM alpine

RUN apk add --no-cache nginx && apk add --no-cache nginx-mod-stream

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN chown -R nginx:nginx /var/lib/nginx

COPY conf /etc/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
