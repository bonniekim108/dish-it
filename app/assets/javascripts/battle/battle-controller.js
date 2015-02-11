(function() {
  'use strict';

  angular.module('app')

  .controller('BattleController', [
    'BattleService',
    function(BattleService) {
      var vm = this;

      vm.curBattle = BattleService.curBattle;
      vm.displayMode = BattleService.displayMode; 

      vm.userCanVote = function () {
        return BattleService.userCanVote();
      };

      vm.upvote = function (restId, comment) {
        BattleService.upvote(restId, comment).then(function(battle) {
          vm.curBattle = battle;
        });
      };

    }
  ]);

})();