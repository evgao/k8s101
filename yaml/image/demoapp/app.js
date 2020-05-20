const http = require('http');
const os = require('os');
console.log("Server starting...");
var handler = function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress);
  response.writeHead(200);
  response.end("You've hit " + os.hostname() + " with IP " + os.networkInterfaces().eth0[0].address + "\n");
};
var www = http.createServer(handler);
www.listen(80);
