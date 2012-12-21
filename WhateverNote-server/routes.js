var note = require('./controllers/note')

exports.route = function (app) {
	app.get('/', function(req, res) {
  	res.send('hello world');
	});
	app.get('/notes', note.index);
	app.get('/note/:id', note.show);
	app.post('/notes', note.create);
	app.delete('/notes/:id', note.destroy);
};