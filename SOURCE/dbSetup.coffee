mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'

dsn = "mongodb://localhost/DirectPlus"

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error:')

operationsRunning = 0

operationDone= () ->
  operationsRunning--
  if operationsRunning <= 0
    confDB.close()
    console.log "setup finished"


confDB.once 'open', ()->
  Seba = new Admin
    firstname: 'Sebastien' 
    lastname: 'Barbieri'
    email: 'seba@rtbf.be'

  operationsRunning++
  try
    Seba.save (err, fabriceData)->
      if err
        console.log "error occured"
        if err.code == 11000
          console.log "admin already added"
      else
        console.log 'Seba as admin added'
      operationDone()
  catch Exception
