(function() {
	'use strict';

	angular.module('app')

	.factory('BattleService', ['$q', 'BattleResource', function($q, BattleResource){

		var service = {};

		var curBattle;

		service.currentBattle = function(){
			var deferred = $q.defer();
			if (curBattle) {
				return curBattle;
			} else {
				var today = new Date();
				var year = today.getFullYear();
				var month = today.getMonth() + 1;
				getSortedBattle(year, month).then(
					function (battle) {
						deferred.resolve(battle);
					},
					function (fail) {
						deferred.reject(fail);
					}
				)
			}
			return deferred.promise;
		};


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


		return service;

	}]);

})();