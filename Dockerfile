# Stage 1: Build the Angular app
FROM harishtw/node-base:alpine AS build

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./

RUN npm install

COPY . .

ARG ENVIRONMENT

RUN ng build --configuration=$ENVIRONMENT --output-path=dist/$ENVIRONMENT --base-href=/

# Stage 2: Serve the Angular app
FROM nginx:1.19.6-alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/$ENVIRONMENT /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]