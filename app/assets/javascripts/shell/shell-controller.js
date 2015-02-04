(function() {
  'use strict';

  angular.module('app')

  .controller('ShellController', [
    '$state',
    '$rootScope',
    'UserService',
    function($state, $rootScope, UserService) {
      var vm = this;

      vm.name = UserService.name;

    }
  ]);


})();