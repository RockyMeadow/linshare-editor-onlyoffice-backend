# Docker container for LinShare - OnlyOffice backend app
#
# Build:
# docker build -t linagora/linshare-editor-onlyoffice-backend .
#

FROM node:10.14.2-stretch-slim
WORKDIR /usr/src/app
COPY package*.json ./
# remove git install after release linshare-api-client
RUN apt-get update && apt-get install -y git && npm install --only:production
COPY . .
EXPOSE 8081
CMD [ "npm", "start" ]
