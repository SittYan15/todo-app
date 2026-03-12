# # syntax=docker/dockerfile:1
# FROM node:12-alpine
# RUN apk add --no-cache python3 g++ make
# WORKDIR /app
# COPY . .
# RUN yarn install --production
# CMD ["node", "src/index.js"]


FROM node:18

WORKDIR /app

# Install build tools and create python alias
RUN apt-get update && apt-get install -y python3 make g++ \
    && ln -s /usr/bin/python3 /usr/bin/python

# Skip puppeteer chromium download
ENV PUPPETEER_SKIP_DOWNLOAD=true

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]