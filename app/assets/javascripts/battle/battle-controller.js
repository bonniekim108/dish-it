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


      vm.displayLimit = function () {
        if (vm.displayMode == 'nominating') {
          return vm.curBattle.restaurants.length;
        } else {
          return 8;
        }
      };

      vm.upvote = function (rest) {
        vm.pendingUpvote = rest;    
        vm.comment = '';
        $('#upvote-modal').foundation('reveal', 'open');
      };

      vm.finalizeUpvote = function () {
        $('#upvote-modal').foundation('reveal', 'close');
        BattleService.upvote(vm.pendingUpvote.id, vm.comment).then(function(battle) {
          vm.curBattle = battle;
        });
      };

    }
  ]);

})();