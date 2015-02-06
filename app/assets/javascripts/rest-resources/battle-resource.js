(function() {
  'use strict';

  angular.module('app')
  .factory('BattleResource', [
    '$resource',
    function ($resource) {
      var Resource = $resource('/api/battles', null,
      {
        // mapping to standard rails methods
        //'index':    {method: 'GET', isArray: true},
        'show':     {
                      // required params = year: & month:
                      url: '/api/battles/:year/:month',
                      method: 'GET',
                      headers : {'Content-Type' : 'application/json'},
                      isArray: false
                    }
        //'create':   {method: 'POST'},
        //'update':   {method: 'PUT'},

        // custom methods

      }
      );

      // Add custom functions

      return Resource;
    }
    ]);

})();