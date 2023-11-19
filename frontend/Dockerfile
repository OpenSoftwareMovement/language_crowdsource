FROM node:18

WORKDIR /app

COPY package.json .
# COPY ./yarn.lock ./yarn.lock

RUN yarn cache clean
RUN yarn install

COPY . .

RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
