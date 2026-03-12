# # syntax=docker/dockerfile:1
# FROM node:12-alpine
# RUN apk add --no-cache python3 g++ make
# WORKDIR /app
# COPY . .
# RUN yarn install --production
# CMD ["node", "src/index.js"]


FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]