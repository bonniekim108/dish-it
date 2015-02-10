(function() {
  'use strict';

  angular.module('app')

  .controller('NominateController', [
    'YelpService', 'BattleService',
    function(YelpService, BattleService) {
      var vm = this;

      vm.BattleService = BattleService;
      vm.battle = BattleService.curBattle;
      vm.searchResults = [];

      vm.updateSearch = function () {
        YelpService.search(vm.searchName, function (data) {
//DEBUG//DEBUG
 console.log(data)         
          vm.searchResults = data;
        });
      };

    }
    ]);

})();