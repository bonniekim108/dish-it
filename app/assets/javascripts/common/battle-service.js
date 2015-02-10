(function() {
	'use strict';

	angular.module('app')

	.factory('BattleService', ['$q', 'BattleResource', function($q, BattleResource){

		var service = {};

		var curBattle;

		service.currentBattle = function(){
			var deferred = $q.defer();
			if ( curBattle ) {
				return curBattle;
			} else {
				var today = new Date();
				var year = today.getFullYear();
				var month = today.getMonth() + 1;
				BattleResource.show({
					year: year, month: month
				},function(battle){
					curBattle = battle;
					deferred.resolve(curBattle);
				},function(fail){
					deferred.reject(fail);
				})
			}
			return deferred.promise;
		};













		return service;

	}]);

})();