# Stage 1: Base Node.js image
FROM node:20-alpine as builder

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Stage 2: Production image
FROM alpine:3.21

RUN apk add --no-cache libstdc++

COPY --from=builder /usr/local /usr/local

RUN node --version && npm --version && ng version

CMD ["node"]