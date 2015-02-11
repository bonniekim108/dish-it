(function() {
  'use strict';

  angular.module('app')

  .controller('ShellController', [
    '$state',
    '$rootScope',
    'UserService',
    function($state, $rootScope, UserService) {
      var vm = this;

      vm.user = UserService.user;

      vm.login = function() {
        UserService.login(vm.email, vm.password).then(
          function(user) {
            vm.user = user;
          }, function() {
            vm.user = null;
          });
        vm.email = vm.password = '';
      };

      vm.logout = function() {
        UserService.logout();
        vm.user = null;
        $state.go('shell.home');
      };

      vm.signup = function() {
        $state.go('shell.signup');
      };

      vm.isUserLoggedIn = function () {
        return UserService.getUser() != null;
      };

    }
  ]);


})();