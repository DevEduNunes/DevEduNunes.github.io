FROM alpine:3.20 AS build
RUN apk add --no-cache bash coreutils sed
WORKDIR /src
COPY . .
RUN bash .github/version-assets.sh \
 && mkdir /site \
 && cp -r index.html 404.html assets .well-known /site/

FROM nginxinc/nginx-unprivileged:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site /usr/share/nginx/html
EXPOSE 8080
