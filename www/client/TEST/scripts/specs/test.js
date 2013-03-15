// Generated by CoffeeScript 1.4.0

define(["jquery", "jasmine-html"], function($, jasmine) {
  var Test;
  return Test = (function() {

    function Test() {}

    Test.prototype.init = function() {
      var htmlReporter, jasmineEnv, specs;
      jasmineEnv = jasmine.getEnv();
      jasmineEnv.updateInterval = 250;
      htmlReporter = new jasmine.HtmlReporter();
      jasmineEnv.addReporter(htmlReporter);
      jasmineEnv.specFilter = function(spec) {
        return htmlReporter.specFilter(spec);
      };
      specs = [];
      specs.push('../../TEST/scripts/specs/seeConference');
      specs.push('../../TEST/scripts/specs/nextPrevious');
      return $(function() {
        return require(specs, function() {
          return jasmineEnv.execute();
        });
      });
    };

    return Test;

  })();
});
