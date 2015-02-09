(function() {
  'use strict';

  angular.module('app')

  .factory('YelpService', ['$http', '$q', 'UserService', function($http, $q, UserService){

    var service = {};

    // Yelp provided credentials
    var consumerKey = 't631eDieM_BP6OZrnI8ipg';
    var consumerSecret = 'CCz2MqKYKjG3vqzCMUJp6FLD6dE';
    var token = 'dJhfXl5eZwMOwiU8NZNM52kJ-UknEt0o';
    var tokenSecret = 'ZvIlgJQHp0qUW30WfNF8uDHtICY';

    // be sure to replace spaces in injected name & city with +'s
    var baseUrl = 'http://api.yelp.com/v2/search';

    var callCount = 0;
    var pending;

    service.search = function (name, callback) {
      if (pending) {
        pending.resolve('cancelled by user');
      }
      pending = $q.defer();
      var method = 'GET';
      var url = 'http://api.yelp.com/v2/search';
      var params = {
        callback: 'angular.callbacks._' + callCount,
        category_filter: 'restaurants',
        location: getCounty(),
        oauth_consumer_key: consumerKey,
        oauth_token: token,
        oauth_signature_method: 'HMAC-SHA1',
        oauth_timestamp: new Date().getTime(),
        oauth_nonce: randomString(32, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),
        limit: 10,
        term: name
      };
      var signature = oauthSignature.generate(method, url, params, consumerSecret, tokenSecret, { encodeSignature: false});
      params.oauth_signature = signature;
      callCount++;
      $http.jsonp(url, {params: params, timeout: pending.promise})
        .success(callback);
    };

    return service;

    /*  private functions  */

    function getCounty () {
      return UserService.getUser().county.name + ' County';
    }

    function randomString(length, chars) {
      var result = '';
      for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
        return result;
    }

  }]);

})();