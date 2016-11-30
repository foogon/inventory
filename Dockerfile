from node:7-alpine
copy . /source
workdir source
run npm install && npm run build
cmd ["npm", "start"]
