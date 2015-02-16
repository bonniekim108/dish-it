(function() {
  'use strict';

  angular.module('app')

  .factory('YelpService', ['$http', '$location', '$q', 'UserService', function($http, $location, $q, UserService){

    var service = {};

    var canceller;

    service.search = function (name) {
      var def = $q.defer();
      if (canceller) canceller.resolve(); // cancel pending request
      canceller = $q.defer();
      $http({url: '/api/yelp', method: 'POST', data: {county: getCounty(), term: name}, timeout: canceller.promise})
        .success(function (data) {
          data = consolidate(data);
          if (canceller) canceller.resolve();
          def.resolve(data);
        });
      return def.promise;
    };

    return service;

    /*  private functions  */

    function getCounty () {
      return UserService.user.county.name + ' County';
    }

    function consolidate (data) {
      data = data.businesses;
      var ret = [];
      var idx;
      _.forEach(data, function (r) {
        idx = _.findIndex(ret, function (e) { return r.name == e.name; });
        if (idx < 0) {
          ret.push(r);
        } else {
          ret[idx].location.city = '-multiple-';
          ret[idx].phone = '-multiple-';
        }
      });
      return _.take(ret, 12);
    }

  }]);

})();
