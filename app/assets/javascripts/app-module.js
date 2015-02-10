(function() {
  'use strict';

  window.app = angular.module('app', [
    'ngResource',
    'ngAnimate',
    'ui.router',
    'templates'
    ])

  // set up the app's routes
  .config([
    '$stateProvider',
    '$urlRouterProvider',
    '$httpProvider',
    function ($stateProvider, $urlRouterProvider, $httpProvider) {

      // send security token to rails with every angular http request
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');

      $stateProvider

      .state('shell', {
        abstract: true,
        url: '',
        templateUrl: 'shell/shell.html',
          // template: "<p>test</p>",
          controller: 'ShellController',
          controllerAs: 'shell',
          resolve: {
            bsReady: ['BattleService',
              function(BattleService) {
                return BattleService.ready;
            }],
            user: ['UserService',
              function(UserService) {
                return UserService.ready;
            }]
          }
      })

      .state('shell.home', {
        url: '/home',
        templateUrl: 'home/home.html',
        controller: 'HomeController',
        controllerAs: 'vm'
      })

      .state('shell.signup', {
        url: '/signup',
        templateUrl: 'signup/signup.html',
        controller: 'SignupController',
        controllerAs: 'vm'
      })

      .state('shell.winners', {
        url: '/winners',
        templateUrl: 'winners/winners.html',
        controller: 'WinnersController',
        controllerAs: 'vm'
      })

      .state('shell.about', {
        url: '/about',
        templateUrl: 'about/about.html'
      })

      .state('shell.battle', {
        url: '/battle',
        templateUrl: 'battle/battle.html',
        controller: 'BattleController',
        controllerAs: 'vm'
      })

      .state('shell.restaurant', {
        url: '/restaurant/:id',
        templateUrl: 'restaurant/restaurant.html',
        controller: 'RestaurantController',
        controllerAs: 'vm'
      })

      .state('shell.nominate', {
        url: '/nominate',
        templateUrl: 'nominate/nominate.html',
        controller: 'NominateController',
        controllerAs: 'vm'
      })

      ;  // $stateProvider chaining

      $urlRouterProvider.otherwise('/home');

  }])  // .config

.run();  // .run

})();