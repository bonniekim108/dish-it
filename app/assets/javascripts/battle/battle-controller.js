(function() {
  'use strict';

  angular.module('app')

  .controller('BattleController', [ 'BattleService',
    // inject other services here
    function(BattleService) {
      var vm = this;

<<<<<<< HEAD
      BattleService.currentBattle().then(function(battle){
      	console.log(battle);
      	vm.curBattle = battle;
      },function(fail){
      	console.log(fail);
      });

      // vm.getBattle = function(){
      // 	return vm.curBattle;
      // }








=======
      vm.curBattle = BattleService.curBattle;
      vm.displayMode = BattleService.displayMode;  
>>>>>>> master



//debugging code
console.log(vm.curBattle);

    }
  ]);

})();