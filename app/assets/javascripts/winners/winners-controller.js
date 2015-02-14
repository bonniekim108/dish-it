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
      vm.restaurantId = $stateParams.id;
      vm.battleId = $stateParams.battle_id;
      vm.restaurant = {};
      vm.battle = {};

      for (var i = 0; i < vm.winners.length; i++){
        if (vm.winners[i].id == vm.battleId) {
          vm.battle = vm.winners[i];
              console.log(vm.battle.restaurants.length);
          for (var j = 0; j < vm.battle.restaurants.length; j++){
            if (vm.battle.restaurants[j].id == vm.restaurantId) {
              vm.restaurant = vm.battle.restaurants[j];
              console.log(vm.restaurant);
            }
          }
        }
      }

    }
    ]);

})();