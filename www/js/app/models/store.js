// Generated by CoffeeScript 1.4.0
var Spine;

require.config({
  baseUrl: 'js/'
});

if (typeof Spine === "undefined" || Spine === null) {
  Spine = require('lib/spine/spine');
}

Spine.Model.Store = {
  extended: function() {
    this.change(this.saveLocal);
    return this.fetch(this.loadLocal);
  },
  saveLocal: function() {
    var result;
    result = JSON.stringify(this);
    return localStorage[this.className] = result;
  },
  loadLocal: function() {
    var result;
    result = localStorage[this.className];
    return this.refresh(result || [], {
      clear: true
    });
  },
  this.find: function(id) {
    return (this.records || (this.records = {}))[id];
  }
};

if (typeof module !== "undefined" && module !== null) {
  module.exports = Spine.Model.Store;
}