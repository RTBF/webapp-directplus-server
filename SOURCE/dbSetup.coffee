mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'

dsn = "mongodb://localhost/DirectPlus"

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error:')

console.log "trying to open database"

confDB.once 'open', ()->
  console.log "open database"

  Seba = new Admin
    firstname: 'Sebastien' 
    lastname: 'Barbieri'
    email: 'seba@rtbf.be'

  Seba.save (err, fabriceData)->
    if err
      console.log "saving error man"
      console.log err
    else
      console.log 'Seba as admin added'
    confDB.close()