define [
  'jquery'
  'backbone'
  'backbonels'
  'application/views/slideScreen'
  'application/models/slide'
  ],($,Backbone,Backbonels,slideScreen,Slide)->


  class slides extends Backbone.Collection
    
    model : Slide

    localStorage: new Backbonels "slidesStore"

    position: 0

  

     
      





  
