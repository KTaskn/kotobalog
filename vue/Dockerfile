FROM node:8.11.3-alpine

RUN apk update
RUN npm install -g @vue/cli
RUN npm install -g @vue/cli-init
RUN npm install vue bootstrap-vue bootstrap
RUN npm install axios@0.18.1

WORKDIR /www

CMD ["/bin/sh"]