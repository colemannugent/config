//Import library dependencies
var fs = require('fs');
var http = require('http');
var https = require('https');
var net = require('net');
var suppose = require('suppose');
var util  = require('util');
var execSync = require('exec-sync');

//Load SSL certification files
var privateKey  = fs.readFileSync('/var/www/cert/ssl.key', 'utf8');
var certificate = fs.readFileSync('/var/www/cert/ssl.crt', 'utf8');

//Declare & instantiate variables 
var credentials = {key: privateKey, cert: certificate};
var express = require('express');
var app = express();
var sslapp = express();
var debugMode = true;
var sslport = 8443;
var port = 8081;

var httpsServer = https.createServer(credentials, sslapp);
var httpServer = http.createServer(app);

httpsServer.listen(sslport);
if (debugMode) { console.log("Server listening for encrypted connections on " + sslport); }

httpServer.listen(port);
if (debugMode) { console.log("Server listening for unencrypted connections on " + port); }

//Listens for requests and calls the appropriate response function
app.get('/', function(req, res){
	//Set header so jQuey autodetects JSON
	res.setHeader('Content-Type', 'application/json');

	if (req.query.panel == "website") {
		sendWebsiteData(res);
	} else if (req.query.panel == "minecraft") {
		sendMinecraftData(res);
	} else if (req.query.panel == "server") {
		sendServerData(res);
	} else {
		res.status(500).send("Malformed request");
	}
	if (debugMode) { console.log("Got request for " + req.query.panel); }
});

//Listens for requests and calls the appropriate response function
sslapp.get('/', function(req, res){
	//Set header so jQuey autodetects JSON
	res.setHeader('Content-Type', 'application/json');

	if (req.query.panel == "website") {
		sendWebsiteData(res);
	} else if (req.query.panel == "minecraft") {
		sendMinecraftData(res);
	} else if (req.query.panel == "server") {
		sendServerData(res);
	} else {
		res.status(500).send("Malformed request");
	}
	if (debugMode) { console.log("Got request for " + req.query.panel); }
});

//Sends data about the apache2 server
function sendWebsiteData(res) {
	var apachemem = execSync('/root/scripts/pmem apache2');
		res.jsonp({"name":  "website panel", "status": "running", "memusage": parseInt(apachemem)});
		if (debugMode) { console.log("Sent website data"); }
}

//Sends data about the minecraft server
function sendMinecraftData(res) {
	var mcmem = execSync('/root/scripts/pmem java');
		res.jsonp({"name":  "minecraft panel", "status": "running", "memusage": parseInt(mcmem)});
		if (debugMode) { console.log("Sent minecraft data"); }
}

function sendServerData(res) {
	var javamem = execSync('/root/scripts/pmem java');
	var apachemem = execSync('/root/scripts/pmem apache2');
	var teamspeakmem = execSync('/root/scripts/pmem ts3server_linux_amd64');
	var uptime = execSync('uptime');
	var totalmem = execSync('/root/scripts/totalmem');
	
	res.jsonp({"name":  "server panel", "mcusage": parseInt(javamem), "tsusage": parseInt(teamspeakmem), "webusage": parseInt(apachemem), "uptime": uptime, "totalmem": parseInt(totalmem)});
	
	if (debugMode) { console.log("Sent server data"); }
}
