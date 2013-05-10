// Generated by CoffeeScript 1.4.0
/*class Serveur
  constructor: () ->

  init: ->
*/

var DBCom, DBCreate, app, express, io, server,
  _this = this;

express = require('express');

app = express();

server = require('http').createServer(app);

io = require('socket.io').listen(server);

server.listen(3000);

io.set('log level', 1);

io.set('transports', ['websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling']);

DBCom = require('./DBCom.js');

DBCreate = require('./DBCreate.js');

io.sockets.on('connection', function(socket) {
  /* CONNECTION DE L'ADMIN
  */

  var brodcastSlide;
  console.log(socket.id);
  socket.on('slider', function(id) {
    DBCom.readSlideListForSlider(id, function(dbdata) {
      return socket.emit('sslides', dbdata);
    });
    return console.log('admin connected');
  });
  /*
  */

  socket.on('reset', function(data) {
    console.log('admin asks for reseting');
    return socket.broadcast.emit('sreset', data);
  });
  /* CONNECTION USER
  */

  socket.on('user', function(data) {
    DBCom.getOrgaList(function(dbdata) {
      return socket.emit('organisations', dbdata);
    });
    return console.log('user connected');
  });
  /* CONNECTION DE L'ADMIN
  */

  socket.on('admin', function(id) {
    console.log("received connection from admin: ", id);
    return DBCom.getOrgaListfromAdmin(id, function(dbdata) {
      console.log(dbdata);
      return socket.emit('organisations', dbdata);
    });
  });
  /* CHOIX DE L'ORGANISATION PAR LE USER
  */

  socket.on('organisationChoosed', function(id) {
    return DBCom.readConference(id, function(dbdata) {
      return socket.emit('conferences', dbdata);
    });
  });
  /* CHOIX DE LA CONFERENCE PAR LE USER
  */

  socket.on('conferenceChoosed', function(id) {
    console.log('conf choosed', id);
    socket.join(id);
    return DBCom.readSlideList(id, function(dbdata) {
      return socket.emit('slides', dbdata);
    });
  });
  /* ENVOIE D'UN SLIDE PAR L'ADMIN
  */

  socket.on('send', function(data) {
    console.log(data);
    return DBCom.readSlideToSend(data, function(dbdata) {
      DBCom.setSent(true, data);
      socket.emit('sent', data);
      return brodcastSlide('snext', dbdata);
    });
  });
  /* RETRAIT D'UN SLIDE PAR L'ADMIN
  */

  socket.on('remove', function(data) {
    return DBCom.readSlideToSend(data, function(dbdata) {
      DBCom.setSent(false, data);
      socket.emit('sremove', data);
      return brodcastSlide('sremove', dbdata);
    });
  });
  /* CREATION D'UN SLIDE PAR L'ADMIN
  */

  socket.on('createSlide', function(data) {
    return DBCreate.CreateSlide(data, function(dbdata) {
      console.log(dbdata);
      return socket.emit('slideCreated', dbdata);
    });
  });
  /* UPDATE D'UN SLIDE PAR L'ADMIN
  */

  socket.on('updateSlide', function(data) {
    return DBCreate.UpdateSlide(data, function(dbdata) {
      socket.emit('slideUpdated', dbdata);
      if (dbdata.Sent === true) {
        return brodcastSlide('slideUpdated', dbdata);
      }
    });
  });
  /* SUPPRESSION D'UNE SLIDE PAR L'ADMIN
  */

  socket.on('deleteSlide', function(data) {
    console.log('reçu un slide à detruire');
    return DBCreate.DeleteSlide(data, function(dbdata) {
      console.log(dbdata);
      socket.emit('slideDeleted', dbdata);
      if (dbdata.Sent === true) {
        return brodcastSlide('sremove', dbdata);
      }
    });
  });
  socket.on('newOrganisation', function(data) {
    return DBCreate.CreateOrganisation(data, function(dbdata) {
      return socket.emit('orgCreated', dbdata);
    });
  });
  socket.on('newConference', function(data) {
    return DBCreate.CreateConference(data, function(dbdata) {
      console.log(dbdata);
      return socket.emit('confCreated', dbdata);
    });
  });
  socket.on('deleteConference', function(data) {
    return DBCreate.DeleteConference(data, function(dbdata) {
      return socket.emit('confDeleted', dbdata);
    });
  });
  socket.on('deleteOrganisation', function(data) {
    return DBCreate.DeleteOrganisation(data, function(dbdata) {
      return socket.emit('orgDeleted', dbdata);
    });
  });
  socket.on('updateOrganisation', function(data) {
    return DBCreate.UpdateOrganisation(data, function(dbdata) {
      return socket.emit('orgUpdated', dbdata);
    });
  });
  socket.on('updateConference', function(data) {
    return DBCreate.UpdateConference(data, function(dbdata) {
      return socket.emit('confUpdated', dbdata);
    });
  });
  return brodcastSlide = function(message, dbdata) {
    console.log(dbdata._conf);
    return io.sockets["in"](dbdata._conf).emit(message, dbdata);
  };
});

console.log('Serveur lancé');