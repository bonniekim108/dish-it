(function() {
  'use strict';

  angular.module('app')

  .controller('NominateController', [
    'YelpService',
    function(YelpService) {
      var vm = this;

vm.test = "this is a test"

    }
    ]);

})();