(function() {
  'use strict';

  angular.module('app')

  .controller('BattleController', [ 'BattleService',
    // inject other services here
    function(BattleService) {
      var vm = this;

      vm.curBattle = BattleService.curBattle;
      vm.displayMode = BattleService.displayMode;  



//debugging code
console.log(vm.curBattle);

    }
  ]);

})();