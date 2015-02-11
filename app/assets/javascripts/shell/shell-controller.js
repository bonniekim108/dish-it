(function() {
  'use strict';

  angular.module('app')

  .controller('ShellController', [
    '$state',
    '$rootScope',
    'UserService',
    function($state, $rootScope, UserService) {
      var vm = this;

      vm.getUser = function () {
        return UserService.getUser();
      };

      vm.login = function() {
        UserService.login(vm.email, vm.password);
        vm.email = '';
        vm.password = '';
      };

      vm.logout = function() {
        UserService.logout();
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