(function() {
  'use strict';

  angular.module('app')

  .controller('WinnersController', [
    'BattleService',
    function(BattleService) {
      var vm = this;

      vm.winners = BattleService.winners;

    }
    ]);

})();