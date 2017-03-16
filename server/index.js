let json = require('json-server'),
    server = json.create(),
    port = process.env.PORT | 4000;

server.use(json.defaults());

let router = json.router('players.json');
server.use(router)

console.log(`Listening on Port ${port}`);
server.listen(port);
