(function() {
  'use strict';

  angular.module('app')

  .controller('RestaurantController', [
    '$stateParams','BattleService',
    function($stateParams,BattleService) {
      var vm = this;

      vm.curBattle = BattleService.curBattle.restaurants; 
      vm.restaurantId = $stateParams.id;
      console.log(BattleService.curBattle);
      vm.userCanVote = function () {
        return BattleService.userCanVote();
      };

      vm.upvote = function (restId, comment) {
        BattleService.upvote(restId, comment).then(function(battle) {
          vm.curBattle = battle;
        });
      };

      for (var i = 0; i < vm.curBattle.length; i++){
        if (vm.curBattle[i].id == vm.restaurantId) {
          return vm.curBattle = vm.curBattle[i];
        }
      }

    }
    ]);

})();