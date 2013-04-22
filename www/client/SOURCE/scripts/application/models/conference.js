// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'backbone', 'application/collections/slides', 'application/models/slide'], function($, Backbone, Slides, Slide) {
  var Conference;
  return Conference = (function(_super) {

    __extends(Conference, _super);

    Conference.prototype.defaults = {
      slidesC: new Slides()
    };

    function Conference(aConf) {
      Conference.__super__.constructor.call(this, aConf);
    }

    Conference.prototype.initialize = function() {
      this.navMode = false;
      this.on('slides', function(data) {
        return this.restore(data);
      });
      return this.on('newSlide', function(data) {
        return this.newSlide(data);
      });
    };

    Conference.prototype.restore = function(data) {
      var len, max, obj, slide, slideLen, taille, x, _i;
      console.log("j'ai été restaurement");
      console.log(this.get('slidesC'));
      this.get('slidesC').fetch();
      len = data.length - 1;
      slideLen = this.get('slidesC').length - 1;
      if (slideLen !== len || data[0]._conf !== this.get('_id')) {
        console.log("jjj");
        this.get('slidesC').reset();
        localStorage.clear();
        this.get('slidesC').fetch();
        for (x = _i = 0; 0 <= len ? _i <= len : _i >= len; x = 0 <= len ? ++_i : --_i) {
          obj = $.parseJSON(data[x].JsonData);
          slide = new Slide(obj);
          this.get('slidesC').add(slide);
          slide.save();
          this.get('slidesC').fetch();
        }
      }
      this.get('slidesC').each(function(slide) {
        return slide.set('state', 'out');
      });
      taille = this.get('slidesC').length;
      max = 3;
      while (max > 0 && taille > 0) {
        taille--;
        slide = this.get('slidesC').at(taille);
        switch (max) {
          case 3:
            slide.set('state', 'current');
            break;
          case 2:
            slide.set('state', 'past');
            break;
          case 1:
            slide.set('state', 'far-past');
        }
        max--;
      }
      console.log(this.get('slidesC'));
      console.log(this.get('slidesC'));
      return this.trigger('change');
    };

    Conference.prototype.newSlide = function(data) {
      var max, obj, slide, slideff, slidet, taille;
      obj = $.parseJSON(data.JsonData);
      slide = new Slide(obj);
      if (this.navMode) {
        slideff = this.get('slidesC').where({
          state: 'far-future'
        });
        if (slideff[0]) {
          slide.set('state', 'out');
        } else {
          slide.set('state', 'far-future');
        }
      } else {
        slide.set('state', 'far-future');
        taille = this.get('slidesC').length;
        max = 3;
        while (max > 0 && taille > 0) {
          taille--;
          slidet = this.get('slidesC').at(taille);
          switch (max) {
            case 3:
              slidet.set('state', 'past');
              break;
            case 2:
              slidet.set('state', 'far-past');
              break;
            case 1:
              slidet.set('state', 'out');
          }
          max--;
        }
      }
      this.get('slidesC').add(slide);
      slide.save();
      this.get('slidesC').fetch;
      console.log(this.get('slidesC'));
      return this.trigger('new');
    };

    return Conference;

  })(Backbone.Model);
});