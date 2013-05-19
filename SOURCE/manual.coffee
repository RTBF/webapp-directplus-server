mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'
Slide = require './Models/Slide.js'
Organisation = require "./Models/Organisation.js"
Conference =  require "./Models/Conference.js"

dsn = "mongodb://localhost/DirectPlus"

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error:')

confDB.once 'open', ()->
  Conference.find (err, confs)=>
    if err
      console.log "erreur: ", err
    for conf in confs
      conf.remove()
      # ...
    