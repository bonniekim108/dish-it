(function() {
  'use strict';

  angular.module('app')
  .factory('BattleResource', [
    '$resource',
    function ($resource) {
      var Resource = $resource('/api/battles', null,
      {
        'show':     {
                      // required params = year: & month:
                      url: '/api/battles/:year/:month',
                      method: 'GET',
                      isArray: false
                    }
      }
    );

      // Add custom functions

      return Resource;
    }
    ]);

})();