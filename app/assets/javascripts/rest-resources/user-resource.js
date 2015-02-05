(function() {
  'use strict';

  angular.module('app')
  .factory('UserResource', [
    '$resource',
    function ($resource) {
      var Resource = $resource('/api/users', null,
      {
        'getUser': {
          method: 'POST',
          url: '/api/get-user',
          // 'params' json has a single key of 'token'
          headers : {'Content-Type' : 'application/json'}
        },
        'login': {
          method: 'POST',
          url: '/api/login',
          // 'params' json has a root key of 'login' and these keys: email & password
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