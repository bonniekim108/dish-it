(function() {
  'use strict';

  angular.module('app')

  .factory('UserService', ['$q', 'UserResource', function($q, UserResource) {


    var service = {};

    var readyDeferred = $q.defer();
    service.ready = readyDeferred.promise;

    // init
    service.user = null;
    UserResource.loginToken(
      function (user) {
        service.user = user;
        readyDeferred.resolve(service.user);
      }, function (nouser) {
        service.user = null;
        readyDeferred.resolve(null);
      }
    );

    service.login = function(email, password) {
      var def = $q.defer();
      UserResource.loginEmail({login: {email: email, password: password}}, function(user){
        service.user = user;
        def.resolve(user);
      }, function(error){ 
        service.user = null;
        def.reject();
      });
      return def.promise;
    };

    service.logout = function() {
      UserResource.logout();
      service.user = null;
    };

    service.signup = function(name, email, password, password_confirmation, county) {
      var deferred = $q.defer();
      UserResource.signup({signup: {name: name, email: email, password: password, password_confirmation: password_confirmation, county: county}}, 
        function(user){
          service.user = user;
          deferred.resolve(user);
        }, function(error) {
          service.user = null;
          deferred.reject(error.data);
        });
      return deferred.promise;
    };

    return service;
  }]);

})();