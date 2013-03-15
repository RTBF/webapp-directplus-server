// Generated by CoffeeScript 1.4.0

define(['application/routes/router', 'application/models/slide', 'application/collections/slides', 'application/views/appView', 'vendors/socketio/socketio'], function(Router, Slide, SlidesList, AppView) {
  /*
      Gere les communication serveur
  */

  var Application;
  return Application = (function() {

    function Application() {
      this.router = new Router();
      this.socket = null;
      this.appView = new AppView();
    }

    Application.prototype.init = function() {
      var _this = this;
      this.socket = io.connect('http://localhost:3000');
      this.socket.on('snext', function(data) {
        console.log("snext received");
        return _this.appView.trigger('newSlide', data);
      });
      this.socket.on('sreset', function(data) {
        localStorage.clear();
        $('#SlideList').empty();
        return Application.slidesList.reset();
      });
      this.socket.on('connect', function(data) {
        return _this.appView.trigger('ServerConnection', data);
      });
      return this.connect();
    };

    Application.prototype.connect = function() {
      return this.socket.emit('user', '');
    };

    return Application;

  })();
});
