FROM strapi/base

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn cache clean
RUN yarn install

COPY . .

ENV NODE_ENV production

RUN yarn build

EXPOSE 1337

CMD ["yarn", "start"]
