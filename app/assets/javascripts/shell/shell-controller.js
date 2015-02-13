(function() {
  'use strict';

  angular.module('app')

  .controller('ShellController', [
    '$state',
    '$interval',
    'UserService',
    function($state, $interval, UserService) {
      var vm = this;

      vm.user = UserService.user;

      vm.countdown = {};
      var eom = moment().endOf("month");
      $interval(function () {
        var diff = moment.duration(eom.diff(moment()));
        vm.countdown.d = diff.days();
        vm.countdown.h = diff.hours();
        vm.countdown.m = diff.minutes();
        vm.countdown.s = diff.seconds();
      }, 1000);

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
        return UserService.getUser() !== null;
      };

      vm.hideMenu = function () {
        return $state.current.name === 'shell.home';
      };

    }
  ]);

  function padToTwo (number) {
    if (number<=9) { number = ("0"+number).slice(-2); }
    return number;
  }


})();