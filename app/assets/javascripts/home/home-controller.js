(function() {
  'use strict';

  angular.module('app')

  .controller('HomeController', [
    // inject other services here
    function() {
      var vm = this;

      vm.testString = "This is DISH*IT !!!";

    }
    ]);

})();