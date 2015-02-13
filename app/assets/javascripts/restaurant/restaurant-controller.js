(function() {
  'use strict';

  angular.module('app')

  .controller('RestaurantController', [
    '$stateParams','BattleService',
    function($stateParams,BattleService) {
      var vm = this;

      vm.curBattle = BattleService.curBattle; 
      vm.restaurantId = $stateParams.id;
      vm.restaurant = {};

      vm.userCanVote = function () {
        return BattleService.userCanVote();
      };

      vm.upvote = function (restId, comment) {
        BattleService.upvote(restId, comment).then(function(battle) {
          vm.curBattle = battle;
        });
      };

      for (var i = 0; i < vm.curBattle.restaurants.length; i++){
        if (vm.curBattle.restaurants[i].id == vm.restaurantId) {
          vm.restaurant = vm.curBattle.restaurants[i];
        }
      }

    }
    ]);

})();