(function() {
  'use strict';

  angular.module('app')
  .factory('UserResource', [
    '$resource',
    function ($resource) {
      var Resource = $resource('/api/users', null,
      {
        'loginEmail': {
          method: 'POST',
          url: '/api/login_email',
          // 'params' json has a root key of 'login' and these keys: email & password
          headers : {'Content-Type' : 'application/json'}
        },
        'loginToken': {
          method: 'GET',
          url: '/api/login_token',
          // no 'params' are passed
          headers : {'Content-Type' : 'application/json'}
        },
        'logout': {
          method: 'GET',
          url: '/api/logout',
          // no 'params' are passed
          headers : {'Content-Type' : 'application/json'}
        },
        'signup': {
          method: 'POST',
          url: '/api/signup',
          // 'params' json has a root key of 'signup' and these keys: name, email, county (id), password & password_confirmation
          headers : {'Content-Type' : 'application/json'}
        }
      }
    );

      // Add custom functions

      return Resource;
    }
  ]);

})();