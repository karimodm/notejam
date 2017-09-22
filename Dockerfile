FROM node:8
ADD ./ /app/
WORKDIR /app

RUN npm install

ENV PORT 3000
EXPOSE 3000

CMD npm start
