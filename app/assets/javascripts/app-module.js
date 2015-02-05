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
          controllerAs: 'shell'
          // resolve: {
          //   currentUser: ['UserResource', '$rootScope',
          //     function(UserResource, $rootScope) {
          //       return UserResource.show({id: user_id}).$promise;
          //     }]
          // }
        })

      .state('shell.home', {
        url: '/home',
        templateUrl: 'home/home.html',
        controller: 'HomeController',
        controllerAs: 'vm'
      })

      .state('shell.register', {
        url: '/register',
        templateUrl: 'register/register.html',
        controller: 'RegisterController',
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

      ;  // $stateProvider chaining

      $urlRouterProvider.otherwise('/home');

  }])  // .config

.run([
  'UserService',
  'UserResource',
  function (UserService, UserResource) {
    if (dishItToken != '') {
      UserResource.loginToken({token: dishItToken}, function(user) {
        UserService.currentUser = user;
      }, function(error) {
        UserService.currentUser = null;
      });
    } else {
      UserService.currentUser = null;
    }

    UserResource.logout();

// UserResource.loginEmail({login:{email: 'jim@email.com', password: 'abc123'}}, function(user){
//   UserService.currentUser = user;
// })


  }
  ]);  // .run

})();