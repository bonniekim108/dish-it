(function() {
  'use strict';

  angular.module('app') // returns the app module

  .factory('SessionService', ['UserResource', 'UserService', function(UserResource, UserService) {

    var service = {};

    // Loads a user from the db and sets a token in the cookie
    // 'params' json has a root key of 'login' and these keys: email & password
    service.login = function (params) {
      UserResource.login(params, function (user) {

      }, function (error) {
        
      });
    };

    // Creates a user in the db and sets a token in the cookie
    // 'params' json has a root key of 'signup' and these keys: name, email, county (id), password & password_confirmation
    service.signup = function (params) {
      UserResource.login(params, function (user) {

      }, function (error) {

      });
    };

    return service;

  }]);

})();