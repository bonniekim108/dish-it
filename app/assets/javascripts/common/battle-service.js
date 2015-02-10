(function() {
	'use strict';

	angular.module('app')

	.factory('BattleService', ['$q', 'BattleResource', function($q, BattleResource){

		var service = {};

		var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth() + 1;

		// this promise has to be resolved before shell will load
		var readyDeferred = $q.defer();
		service.ready = readyDeferred.promise;

		service.displayMode = null;  // set when curBattle is retrieved
		
		service.curBattle = new BattleResource();
		service.curBattle.$show({year: year, month: month}).then(
			function (battle) {
				var sorted = _.sortBy(battle.restaurants, function(r) {
					return r.votes.length * -1;
				});
				battle.restaurants = sorted;
				service.displayMode = getDisplayMode();
				readyDeferred.resolve();
			});



		/*  Private Functions  */

		function getSortedBattle(yr, mo) {
			var deferred = $q.defer();
			BattleResource.show({
				year: yr, month: mo
			}, function (battle) {
				var sorted = _.sortBy(battle.restaurants, function(r) {
					return r.votes.length * -1;
				});
				battle.restaurants = sorted;
				deferred.resolve(battle);
			}, function (fail) {
				deferred.reject(fail);
			});
			return deferred.promise;
		}

		function getDisplayMode() {
			var diff = moment(service.curBattle.year_month, 'YYYY-MM-DD').date() - moment().date();
			switch (true) {
				case diff < 0:
				return 'winner';
				case diff < 7:
				return 'final-four';
				case diff < 14:
				return 'great-eight';
				case diff < 31:
				return 'nominating';
				default:
				return 'future';
			}
		}

		return service;

	}]);

})();