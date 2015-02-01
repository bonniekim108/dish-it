(function() {
  'use strict';

  angular.module('app')

  .controller('RestaurantController', [
    '$stateParams',
    function($stateParams) {
      var vm = this;

      vm.restaurantId = $stateParams.id;

    }
    ]);

})();