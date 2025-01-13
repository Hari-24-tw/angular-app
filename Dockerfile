# Use the official Node.js image as the base image
FROM harishtw/node-base:20-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the Angular app for the specified environment
ARG ENVIRONMENT
RUN ng build --progress=false -c=$ENVIRONMENT --output-path=dist/$ENVIRONMENT --base-href=/

# Expose the port the app runs on
EXPOSE 80

# Serve the app using a simple web server
RUN npm install -g http-server

WORKDIR /app/dist/$ENVIRONMENT

CMD ["http-server", "-p", "80"]