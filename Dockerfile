FROM node:carbon-alpine as builder
WORKDIR /tmp/

COPY . .
RUN npm install
RUN npm run build:prod

FROM node:carbon-alpine

WORKDIR /app
COPY --from=builder /tmp ./
RUN rm -rf src test && rm -rf node_modules && npm i --production
ENTRYPOINT ["npm", "run"]
CMD ["start:prod"]
