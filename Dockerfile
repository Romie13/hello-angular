##STAGE 1:Build Angular application ##
FROM node:8 as builder
RUN mkdir /angcode
COPY . /angcode
WORKDIR /angcode
RUN npm install
RUN $(npm bin)/ng build

##STAGE 2:Run nginx to serve application ##
FROM nginx
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /angcode/dist/ /usr/share/nginx/html/
COPY ./nginx/nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
