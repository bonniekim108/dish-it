(function() {
  'use strict';

  angular.module('app')

  .factory('UserService', ['$q', 'UserResource', function($q, UserResource) {

    var service = {};

    service.getUser = function () {
      return service.user;
    };

    service.login = function(email, password) {
      UserResource.loginEmail({login: {email: email, password: password}}, function(user){
        service.user = user;
      }, function(error){ 
        service.user = null;
      });
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

    service.loginToken = function() {
      UserResource.loginToken(function (user) {
        if (user == 'no-token') {
          service.user = null;
        } else {
          service.user = user;
        }
      });
    };

    return service;
  }]);

})();