(function() {
  'use strict';

  angular.module('app')
  .factory('UserResource', [
    '$resource',
    function ($resource) {
      var Resource = $resource('/api/users', null,
        {
          // mapping to standard rails methods
          // 'index':    {method: 'GET', isArray: true},
          // 'show':     {method: 'GET', isArray: false},
          // 'create':   {method: 'POST'},
          // 'update':   {method: 'PUT'},
          // other methods in rails UsersController
          'getUser': {
                        method: 'GET',
                        url: '/api/get-user',
                        // params:{token: '@token'},
                        headers : {'Content-Type' : 'application/json'}
                      }
        }
      );

      // Add custom functions

      return Resource;
    }
  ]);

})();