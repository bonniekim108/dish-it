(function() {
  'use strict';

  angular.module('app') // returns the app module

  .factory('UserService', ['$resource', function($resource) {
    
    var serviceInstance = {};

    serviceInstance.name = "bonnie"















    return serviceInstance;
}]);

  })();