(function() {
	'use strict';

	angular.module('app')

	.factory('BattleService', ['$q', '$http', 'BattleResource', 'UserService', function($q, $http, BattleResource, UserService){

		var service = {};

		var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth() + 1;

		// this promise has to be resolved before shell will load
		var readyDeferred = $q.defer();
		service.ready = readyDeferred.promise;
		
		// load current battle
		getSortedBattle(year, month).then(function(battle) {
			service.curBattle = battle;
			service.displayMode = getDisplayMode();
			readyDeferred.resolve();
		});

		service.upvote = function (restId, comment) {
			var def = $q.defer();
			var config = {
				url: '/api/battles/upvote',
				method: 'POST',
				data: {
					vote: {
						restaurant_id: restId,
						comment: comment
					}
				}
			};
			$http(config).success(function (battle) {
				var sorted = sortByVotes(battle);
				service.curBattle.restaurants = sorted;
				def.resolve(service.curBattle);
			});
			return def.promise;
		};

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

		function userVoted (numRestToCheck) {
			var uId = UserService.user.id;
			var n = n || service.curBattle.restaurants.length;
			var findIndex;
			for (var i = 0; i < n; i++) {
				findIndex = _.findIndex(service.curBattle.restaurants[i].votes, function(v) { return v.user.id == uId; });
				if ( findIndex >= 0 ) return true;
			}
			return false;
		}

		function sortByVotes (battle) {
			var sorted = _.sortBy(battle.restaurants, function(r) {
				return r.votes.length * -1;
			});
			return sorted;
		}

		function getSortedBattle (yr, mo) {
			var deferred = $q.defer();
			var newBat = new BattleResource();
			newBat.$show({
				year: yr, month: mo
			}, function (battle) {
				battle.restaurants = sortByVotes(battle);
				deferred.resolve(newBat);
			}, function (fail) {
				deferred.reject(fail);
			});
			return deferred.promise;
		}

		function getDisplayMode () {
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