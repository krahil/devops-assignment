# build environment
FROM node:12.10.0

WORKDIR /usr/src/app

ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY package.json /usr/src/app/package.json

RUN npm install --silent
RUN npm ci -qy
#RUN npm install react-scripts@3.0.1 -g --silent

COPY . /usr/src/app

CMD ["npm", "run", "watch"]
