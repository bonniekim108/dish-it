(function() {
  'use strict';

  angular.module('app')

  .factory('UserService', ['UserResource', function(UserResource) {

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
      UserResource.signup({signup: {name: name, email: email, password: password, password_confirmation: password_confirmation, county: county}}, 
        function(user){
          service.user = user;
        }, function(error) {
          service.user = null;
        });
    };

    service.loginToken = function(token) {
      UserResource.loginToken({token: token}, function(user){
        service.user = user;
      }, function(error){ 
        service.user = null;
      });
    };

    return service;
  }]);

})();