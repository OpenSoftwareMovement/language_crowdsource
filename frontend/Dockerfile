FROM node:12-alpine

WORKDIR /usr/src/app

COPY ./package.json ./package.json
COPY ./yarn.lock ./yarn.lock

RUN yarn install --ignore-engines

COPY . .

RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
