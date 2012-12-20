var mongoose = require('mongoose');
var db = mongoose.createConnection('mongodb://localhost:27017/notes')
var NoteSchema = mongoose.Schema({
	title: String,
	content: String,
	author: String
});

exports.Note = db.model('Note',NoteSchema);