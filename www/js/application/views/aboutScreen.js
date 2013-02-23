// Generated by CoffeeScript 1.3.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'backbone', 'text!application/templates/about/about.html'], function($, Backbone, AboutTemplate) {
  var aboutScreen;
  return aboutScreen = (function(_super) {

    __extends(aboutScreen, _super);

    function aboutScreen(options) {
      aboutScreen.__super__.constructor.call(this, options);
    }

    aboutScreen.prototype.render = function() {
      $(this.el).html(AboutTemplate);
      return console.log("aboutScreen Render called");
    };

    return aboutScreen;

  })(Backbone.View);
});