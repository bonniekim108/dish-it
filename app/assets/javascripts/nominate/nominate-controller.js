(function() {
  'use strict';

  angular.module('app')

  .controller('NominateController', [
    'YelpService', 'BattleService','$state',
    function(YelpService, BattleService, $state) {
      var vm = this;

      vm.BattleService = BattleService;
      vm.battle = BattleService.curBattle;
      vm.searchResults = [];

      vm.updateSearch = function () {
        YelpService.search(vm.searchName, function (data) {    
          vm.searchResults = data;
        });
      };

      vm.nominate = function (yelpRest) {
        vm.pendingNom = yelpRest;    
        vm.comment = '';
        $('#nom-modal').foundation('reveal', 'open');
      };

      vm.finalizeNom = function () {
        $('#nom-modal').foundation('reveal', 'close');
// console.log('nominated: ', vm.pendingNom);
// console.log('comment: ', vm.comment);
        // the restaurant data is in vm.pendingNom & the comment is in vm.comment
        BattleService.nominate(vm.pendingNom, vm.comment).then(function() {
          $state.go('shell.battle');
        });
      };

    }
    ]);

})();