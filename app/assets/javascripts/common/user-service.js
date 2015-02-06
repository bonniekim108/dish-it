(function() {
  'use strict';

  angular.module('app') // returns the app module

  .factory('UserService', ['UserResource', function(UserResource) {
    
    var service = {};

    service.login = function(email, password) {

      UserResource.loginEmail({login: {email: email, password: password}}, function(user){

        service.currentUser = user;
        console.log(user);

      }, function(error){ 
        service.currentUser = null;

      });

    };

    service.signup = function(name, email, password, password_confirmation, county) {

      UserResource.signup({signup: {name: name, email: email, password: password, password_confirmation: password_confirmation, county: county}}, 
        function(user){
          service.currentUser = user;
          console.log(user);

        }, function(error) {
            service.currentUser = null;
        });
    };


    service.loginToken = function(token) {

      UserResource.loginToken({token: token}, function(user){

        service.currentUser = user;
        console.log(user);

      }, function(error){ 
        service.currentUser = null;

      });

    };




    return service;
}]);

  })();