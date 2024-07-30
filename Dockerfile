FROM python:3.9-slim AS builder

WORKDIR /app

RUN pip install mkdocs

COPY project ./

RUN mkdocs build


FROM nginx:latest 

#USER nginx

COPY --from=builder /app/site /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]