mongoose = require 'mongoose'
Schema = mongoose.Schema
Admin = require './Models/Admin.js'
Slide = require './Models/Slide.js'
Organisation = require "./Models/Organisation.js"
Conference =  require "./Models/Conference.js"
Config = require "./config"
dsn = Config.dsn
mongoose.createConnection dsn
confDB = mongoose.connection
confDB.on 'error', console.error.bind(console, 'connection error create:')

module.exports.CreateSlide = CreateSlide = (newslide , callback)=>
  conf=newslide._conf
  type=newslide.type
  jsonData= newslide.jsonData

  Conference
  .findOne
    _id : conf
    (err, conference)=>
      slide1 = new Slide
        _conf: conference._id
        Type: type
        Sent: false
        JsonData: jsonData

      slide1.save (err, slide1)->
        if err
          console.log "erreur", err
      callback(slide1)
      conference.slides.push slide1
      conference.save (err, conference)->
        #
  .populate('slides')
  .exec (err, conferences)=>
    #

  
module.exports.UpdateSlide = UpdateSlide = (newslide , callback)=>
  id=newslide._id
  jsonData= newslide.jsonData

  Slide.findByIdAndUpdate id , 
    JsonData:jsonData 
  , 
    new: true 
  , 
    (err, slide)=>
      callback(slide)
      
module.exports.DeleteSlide = DeleteSlide = (slideId , callback)=>
  Slide.findByIdAndRemove slideId, (err, slide)=>
    if err
      console.log err
    callback slide

module.exports.CreateConference = CreateConference = (newconf, callback)=>
  try
    # ...

    
    Organisation
    .findOne
      _id : newconf._orga
      (err, organisation)=>

        try
          mydate = new Date newconf.date
          conference= new Conference
            _orga: newconf._orga
            name : newconf.name
            date : mydate
            tumb : newconf.tumb
            description : newconf.description
        
          conference.save (err, conference) ->
            if err
              console.log "save erreur", err
            callback conference
            organisation.conferences.push conference
            organisation.save (err, organisation)->
              #
          # ...
        catch e
          console.log err
          # ...
        
        
    .populate('conferences')
    .exec (err, organisations)=>
      #
  catch e
    # ...


module.exports.CreateOrganisation = CreateOrganisation = (newOrg, callback)=>
  Admin
  .findOne
    email : 'seba@rtbf.be'
    (err, admin)=>
      console.log "admin: ", admin
      console.log "new org: ", newOrg
      organisation= new Organisation
        _admin: admin._id
        name : newOrg.title
        tumb : newOrg.tumb
        description : newOrg.description

      organisation.save (err, organisation) ->
        if err
          console.log "erreur", err
        callback organisation
        admin.organisations.push organisation
        admin.save (err, admin)->
          #
  .populate('organisations')
  .exec (err, admins)=>
    #

module.exports.DeleteConference = DeleteConference= (confId, callback)=>
  Slide.find
    _conf:confId
    (err, slides)=>
      for x in slides
        slides[x].remove (err)->
          #...

  Conference.findByIdAndRemove confId, (err, conference)=>
    if err
      console.log err
    callback conference._id

module.exports.DeleteOrganisation = DeleteOrganisation= (orgId, callback)=>

  Conference.find
    _orga:orgId
    (err, conferences)=>
      for x in conferences
        @DeleteConference conferences[x]._id
          # ...

  Organisation.findByIdAndRemove orgId, (err, organisation)=>
    if err
      console.log err
    callback organisation._id

module.exports.UpdateConference = UpdateConference= (nconference, callback)=>
  
  Conference.findByIdAndUpdate nconference._id,
    name: nconference.name
    date: nconference.date
    tumb: nconference.tumb
    description: nconference.description
  ,
    new: true
  , 
    (err, conference) ->
      callback conference


module.exports.UpdateOrganisation = UpdateOrganisation= (norganisation, callback)=>
  Organisation.findByIdAndUpdate norganisation._id , 
    name: norganisation.title
    tumb: norganisation.tumb
    description:norganisation.description
  ,
    new: true 
  , 
    (err, organisation)=>
      console.log "organisation updated: ", organisation
      callback(organisation)

