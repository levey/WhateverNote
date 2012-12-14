var Note = require('../models/note');
var sanitize = require('validator').sanitize;

exports.index = function(req, res) {
	res.send('hello world');
};


exports.create = function(req, res, next) {
	var note = new Note();
	note.title = res.body.title;
	note.content = res.body.content;
	note.author = res.body.author;

	note.save( function(err) {
		if (err) {
			return next(err);
		}
		return { success: 1 };
	});
}