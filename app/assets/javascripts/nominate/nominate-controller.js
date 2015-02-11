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
          vm.searchResults = data;
        });
      };

      vm.nominate = function (restId, comment) {
        BattleService.upvote(restId, comment);
      };

    }
    ]);

})();