(function() {
  'use strict';

  angular.module('app')

  .controller('ShellController', [
    '$state',
    '$interval',
    '$rootScope',
    'UserService',
    function($state, $interval, $rootScope, UserService) {
      var vm = this;

      vm.user = UserService.user;
      // timer that counts down days, hours, minutes, seconds
      vm.countdown = {};
      var eom = moment().endOf("month");
      $interval(function () {
        var diff = moment.duration(eom.diff(moment()));
        vm.countdown.d = padToTwo(diff.days());
        vm.countdown.h = padToTwo(diff.hours());
        vm.countdown.m = padToTwo(diff.minutes());
        vm.countdown.s = padToTwo(diff.seconds());
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
      // user is directed to the home page upon logout
      vm.logout = function() {
        UserService.logout();
        vm.user = null;
        $state.go('shell.home');
      };

      vm.isUserLoggedIn = function () {
        return UserService.getUser() !== null;
      };

      vm.hideMenu = function () {
        return $state.current.name === 'shell.home';
      };

      $rootScope.$on('user-signedup', function () {
        vm.user = UserService.user;
      });

      // demo mode code
      vm.demoMode = null;
      vm.setDemoMode = function (mode) {
        $rootScope.demoMode = mode;
        vm.demoMode = mode;
        $rootScope.$emit('demo-mode-changed');
      };
      vm.showDemo = function () {
        return ($state.current.name === 'shell.battle');
      };
      // end of demo mode code

    }
  ]);

  function padToTwo (number) {
    if (number<=9) { number = ("0"+number).slice(-2); }
    return number;
  }


})();