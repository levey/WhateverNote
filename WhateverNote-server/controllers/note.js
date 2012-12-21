var Note = require('../models/note').Note;

exports.index = function(req, res) {
	Note.find(function(err, notes) {
		if (!err) {
			res.send(notes);
		} else {
			res.send(err);
		}
	});
}

exports.show = function(req, res) {
	Note.findById(req.params.id, function (err, note) {
    if (!err) {
      res.send({success: 1, note: note});
    } else {
    	res.send({success: 0});
    }
  });
}

exports.create = function(req, res) {
	var note = new Note();
	note.title = req.body.title;
	note.content = req.body.content;
	note.author = req.body.author;
	console.log(note);
	note.save(function(err){
		if (!err) {
			res.send({success: 1});
		} else {
			res.send({success: 0});
		}
	});
}

exports.destroy = function(req, res) {
	if (!req.params.id) {
		res.send({success: 0, error: "Need <id> parameter."});
	} else {
		Note.findById(req.params.id, function (err, note) {
	    if (!err) {
	    	if (note) {
	    		note.remove(function(err) {
	      		if (!err) {
	      			res.send({success: 1});
	      		} else {
	      			res.send({success: 0, error: "Failed to delete."});
	      		}
	      	});
	    	} else {
	    		res.send({success: 0, error: "Can not find note."});
	    	}
	    } else {
	    	res.send({success: 0, error: "Failed to delete."});
	    }
	  });
	}
}