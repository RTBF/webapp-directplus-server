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



module.exports.readConference = readConference = (OrgId, page, callback)->
  Confs = []
  finish= page*5
  start = finish - 5
  finish--
  Organisation
  .findOne 
    _id:OrgId
    (err, organisation)=>
      if err
        console.log "error while trying to find the organisations of this admin"
  .populate('conferences')
  .exec (err, organisation)=>
    console.log organisation
    if organisation.conferences.length >0
      console.log organisation.conferences
      len = organisation.conferences.length - 1
      orderArray organisation.conferences, len, (orderedConfs)=>
        getConfsToSend page, start, finish, orderedConfs, (confToSend)=>
          callback confToSend
    else
      callback Confs

getConfsToSend= (page, start, finish, orderedConfs, callback)->
  Confs=[]
  now = new Date()
  x=0
  nonok= true
  while x<orderedConfs.length and nonok
    if orderedConfs[x].date.getTime()<now.getTime()
      x++
    else
      nonok= false
      # ...C
  start = start + x
  finish = finish + x
  if page is 1
    Confs.push orderedConfs[start-3] if start-3 >= 0
    Confs.push orderedConfs[start-2] if start-2 >= 0
    Confs.push orderedConfs[start-1] if start-1 >= 0
  for i in [start..finish]
    Confs.push orderedConfs[i] if orderedConfs[i]
  callback Confs



module.exports.readConferenceForAdmin = readConferenceForAdmin = (OrgId, callback)->
  Confs = []
  Organisation
  .findOne 
    _id:OrgId
    (err, organisation)=>
      if err
        console.log "error while trying to find the organisations of this admin"
  .populate('conferences')
  .exec (err, organisation)=>
    if organisation.conferences
      if organisation.conferences.length >0
        for conf in organisation.conferences
          Confs.push conf
        callback Confs
      else
        callback Confs
    else
      callback Confs 



module.exports.readAllConferences= readAllConferences = (page, callback)->
  Confs = []
  finish= page*5
  start = finish - 5
  finish--
  Conference.find (err, confs)=>

    if err
      console.log "erreur: ", err
    
    if confs.length >0
      len  = confs.length - 1
      orderArray confs, len, (orderedConfs)=>
        getConfsToSend page, start, finish, orderedConfs, (confToSend)=>
          callback confToSend
    else
      callback Confs

orderArray = (array, len, callback)->
  if len is 0
    callback array
  else
    for i in [1..len] 
      if i>0
        for i in [1..len]
          elt= array[i]
          j= i
          while j>0 and array[j-1].date.getTime() > elt.date.getTime()
            array[j]=array[j-1]
            j--
          array[j]=elt
    callback array
    
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

