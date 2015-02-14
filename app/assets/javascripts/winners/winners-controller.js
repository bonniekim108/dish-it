(function() {
  'use strict';

  angular.module('app')

  .controller('WinnersController', [
    '$stateParams',
    'BattleService',
    '$state',
    function($stateParams, BattleService, $state) {
      var vm = this;

      vm.winners = BattleService.winners;
      console.log($stateParams);
      // vm.restaurantId = $stateParams.id;
      // vm.battleId = $stateParams.battle_id;
      // vm.restaurant = {};


      // for (var i = 0; i < n; i++) {
      //   findIndex = _.findIndex(vm.battleId.restaurants[i].id, function(v) { return v.restaurant.id == uId; });
      //   if ( findIndex >= 0 ) return true;
      // }



      // vm.restaurantId = $stateParams.id;
      // vm.restaurant = {};
          
      // for (var i = 0; i < vm.winners.restaurants.length; i++){
      //   if (vm.winners.restaurants[i].id == vm.restaurantId) {
      //     vm.restaurant = vm.winners.restaurants[i];
      //   }
      // }

    }
    ]);

})();