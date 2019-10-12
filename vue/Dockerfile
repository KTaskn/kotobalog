FROM node:8.11.3-alpine

RUN apk update
RUN npm install -g @vue/cli
RUN npm install -g @vue/cli-init
RUN npm install vue bootstrap-vue bootstrap
RUN npm install @auth0/auth0-spa-js
RUN npm install axios

WORKDIR /www

CMD ["/bin/sh"]