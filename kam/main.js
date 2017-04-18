var restify = require('restify')
var server = restify.createServer()
var parser = require('./parser');
server.use(restify.queryParser())
server.get('/parse', function(req, res) {
	var input = req.params.input.substring(1, req.params.input.length - 1);
	console.log(input);
	return res.send(parser.parse(input));
});

server.listen(process.env.PORT || 3000, function() {
	console.log('listening');
})