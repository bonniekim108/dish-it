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
    var baseUrl = 'http://api.yelp.com/v2/search';
    var optionalLocation = '&location={city}';

    var callCount = 0;


    service.search = function (name, city, callback) {
      var method = 'GET';
      var url = 'http://api.yelp.com/v2/search';
      var params = {
        callback: 'angular.callbacks._' + callCount,
        location: city,
        oauth_consumer_key: consumerKey,
        oauth_token: token,
        oauth_signature_method: 'HMAC-SHA1',
        oauth_timestamp: new Date().getTime(),
        oauth_nonce: randomString(32, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),
        term: name
      };
      var signature = oauthSignature.generate(method, url, params, consumerSecret, tokenSecret, { encodeSignature: false});
      params['oauth_signature'] = signature;
      callCount++;
      $http.jsonp(url, {params: params}).success(callback);

    };


    service.search('food+yardhouse', 'los+angeles', function(data){
      console.log(data);
    });
    service.search('restaurants+sharkys', 'west+covina', function(data){
      console.log(data);
    });



    return service;

    /*  private functions  */

    function randomString(length, chars) {
      var result = '';
      for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
        return result;
    }

  }]);

})();