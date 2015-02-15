(function() {
  'use strict';

  angular.module('app')

  .controller('BattleController', [
    '$rootScope',
    'BattleService',
    '$state',
    function($rootScope, BattleService, $state) {
      var vm = this;

      vm.curBattle = BattleService.curBattle;
      vm.displayMode = BattleService.getDisplayMode(); 

      // demo mode code
      $rootScope.$on('demo-mode-changed', function () {
        vm.displayMode = BattleService.getDisplayMode();
      });

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

      vm.getDisplayMode = function () {
        switch (vm.displayMode) {
          case 'winner':
            return 'Winner';
          case 'final-four':
            return 'The Final 4';
          case 'great-eight':
            return 'The Great 8';
          case 'nominating':
            return 'Open Nominations';
          default:
            return 'future';
        }
      };

    }
  ]);

})();