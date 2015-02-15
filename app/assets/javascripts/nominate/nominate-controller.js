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
        var curBattle = BattleService.curBattle;
        var restFound;
        YelpService.search(vm.searchName, function (data) {
          _.forEach(data, function (yelpRest) {
            restFound = BattleService.lookupRestByName(curBattle, yelpRest.name);
            if (restFound) {
              yelpRest.alreadyNominated = true;
              yelpRest.restId = restFound.id;
            } else {
              yelpRest.alreadyNominated = false;
            }
          });
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
        if (vm.pendingNom.alreadyNominated) {
          BattleService.upvote(vm.pendingNom.restId, vm.comment).then(function() {
            $state.go('shell.battle');
          });
        } else {
          // the restaurant data is in vm.pendingNom & the comment is in vm.comment
          BattleService.nominate(vm.pendingNom, vm.comment).then(function() {
            $state.go('shell.battle');
          });
        }
      };

    }
    ]);

})();