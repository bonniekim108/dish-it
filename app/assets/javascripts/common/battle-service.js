(function() {
	'use strict';

	angular.module('app')

	.factory('BattleService', ['$q', 'BattleResource', 'UserService', function($q, BattleResource, UserService){

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

		service.userCanVote = function () {
			switch (service.displayMode) {
				case 'winner', 'future':
					return false;
				case 'nominating':
					return !userVoted(null);
				case 'great-eight':
					return !userVoted(8);
				case 'final-four':
					return !userVoted(4);
				default:
					return false;
			}
		};


		/*  Private Functions  */

		function userVoted(numRestToCheck) {
			var uId = UserService.getUser().id;
			var n = n || service.curBattle.restaurants.length;
			var findIndex;
			for (var i = 0; i < n; i++) {
				findIndex = _.findIndex(service.curBattle.restaurants[i].votes, function(v) { return v.user.id == uId; });
				if ( findIndex >= 0 ) return true;
			}
			return false;
		}

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