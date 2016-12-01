from node:7-alpine
workdir /source
copy package.json .
run npm install
copy . .
run npm run build
entrypoint ["npm", "run"]
cmd ["start"]
