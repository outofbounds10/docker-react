# First section for build

FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN yarn install

COPY . .

RUN yarn run build

# Second section is to serve build assets using nginx

FROM nginx

# copy from builder phase
COPY --from=builder /app/build /usr/share/nginx/html

# No need to start nginx, it starts it automatically due to the nginx image