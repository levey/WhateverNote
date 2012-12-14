var mongoose = require('mongoose');
var db = mongoose.createConnection('mongodb://localhost/notes')
var NoteSchema = mongoose.Schema({
	title: { type: String },
	content: { type: String },
	author: { type: String }
});
mongoose.model('Note',NoteSchema);