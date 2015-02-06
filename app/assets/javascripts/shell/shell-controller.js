(function() {
  'use strict';

  angular.module('app')

  .controller('ShellController', [
    '$state',
    '$rootScope',
    'UserService',
    function($state, $rootScope, UserService) {
      var vm = this;
console.log(UserService);

      vm.userService = UserService;

      vm.currentUser = vm.userService.currentUser;
      vm.name = vm.currentUser.name;
      console.log(vm.name)


      vm.login = function() {
alert(vm.currentUser.name);

      };
      vm.logout = function() {
alert("logout");

      };
      vm.signup = function() {
alert("signup");

      };




    }
    ]);



})();