// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

require.config({
  baseUrl: 'js/',
  paths: {
    jquery: 'lib/jquery/jquery',
    spine: 'lib/spine/spine',
    handlebars: 'lib/handlebars/handlebars'
  }
});

define('app', ['jquery', 'spine', 'handlebars'], function($) {
  var App;
  return App = (function(_super) {

    __extends(App, _super);

    function App() {
      App.__super__.constructor.apply(this, arguments);
    }

    return App;

  })(Spine.controller);
});
