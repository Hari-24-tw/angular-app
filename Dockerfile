#stage 1
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install -g @angular/cli

RUN npm install

COPY . .

ARG ENVIRONMENT

RUN ng build --progress=false -c=$ENVIRONMENT --output-path=dist/$ENVIRONMENT --base-href=/

#stage 2
FROM node:20-alpine

COPY --from=build /app/dist/$ENVIRONMENT /app/dist/$ENVIRONMENT

EXPOSE 80

WORKDIR /app/dist/$ENVIRONMENT

CMD ["http-server", "-p", "80"]