FROM node:18.4.0-alpine3.16
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY . .
CMD [ "npm", "run", "start" ]