(function() {
  'use strict';

  angular.module('app')

  .factory('YelpService', ['$http', function($http){

    var service = {};

    // Yelp provided credentials
    var consumerKey = 't631eDieM_BP6OZrnI8ipg';
    var consumerSecret = 'CCz2MqKYKjG3vqzCMUJp6FLD6dE';
    var token = 'dJhfXl5eZwMOwiU8NZNM52kJ-UknEt0o';
    var tokenSecret = 'ZvIlgJQHp0qUW30WfNF8uDHtICY';

    // be sure to replace spaces in injected name & city with +'s
    var baseUrl = 'api.yelp.com/v2/search?term=restaurants+{name}';
    var optionalLocation = '&location={city}';

    service.search = function (name, city) {



    };


    return service;

  }]);

})();