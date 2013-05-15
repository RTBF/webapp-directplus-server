mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'
Slide = require './Models/Slide.js'
Organisation = require "./Models/Organisation.js"
Conference =  require "./Models/Conference.js"

Config = require "./config"

dsn = Config.dsn

mongoose.connect dsn

confDB = mongoose.connection

confDB.on 'error', console.error.bind(console, 'connection error com:')


module.exports.getOrgaListfromAdmin = getOrgaListfromAdmin = (AdminEmail , callback)=>
  organisation = null
  Admin
  .findOne 
    email:AdminEmail
    (err, admin)=>
      console.log admin
      if err
        console.log err
        return
        #console.log "error while trying to find the organisations of this admin"
  .populate('organisations')
  .exec (err, admin)=>
    organisations =  admin.organisations
    callback(organisations)


module.exports.getOrgaList = getOrgaList = (callback)=>
  organisation = null

  Organisation.find (err, organisations) =>
    if (err)
      console.log "find erreur man"
    if organisations.length > 0 
      organisation =  organisations
      callback(organisation)



module.exports.readConference = readConference = (OrgId, callback)->
  Confs = null
  Organisation
  .findOne 
    _id:OrgId
    (err, organisation)=>
      if err
        console.log "error while trying to find the organisations of this admin"
  .populate('conferences')
  .exec (err, organisation)=>
    Confs = organisation.conferences
    callback Confs


module.exports.readSlideList = readSlideList = (ConfId, callback)->
  slides = []
  Conference
  .findOne 
    _id:ConfId
    (err, conference)=>
      if err
        console.log "error while trying to find the organisations of this admin"
  .populate('slides')
  .exec (err, conferences)=>
    #len = conferences.slides.length - 1
    for slide in conferences.slides
      if slide.Sent
        slides.push slide
    callback slides

module.exports.readSlideListForSlider = readSlideListForSlider = (ConfId, callback)->
  slides = null
  Conference
  .findOne 
    _id:ConfId
    (err, conference)=>
      if err
        console.log "error while trying to find the organisations of this admin"
  .populate('slides')
  .exec (err, conference)=>
    callback conference.slides


module.exports.readSlideToSend = readSlideToSend = (slideId, callback)->
  Slide.findOne
    _id:slideId
    (err, slide)=>
      if err
        console.log "voici l'erreur", err
      callback (slide)

module.exports.setSent = setSent = (sent, id)->
  Slide.update 
    _id: id
  , 
    Sent: sent
  , 
    multi:true
  , 
    (err, numberAffected, raw)->
      #

