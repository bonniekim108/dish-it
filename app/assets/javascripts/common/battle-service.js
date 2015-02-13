(function() {
	'use strict';

	angular.module('app')

	.factory('BattleService', ['$q', '$http', '$rootScope', 'BattleResource', 'UserService', function($q, $http, $rootScope, BattleResource, UserService){

		var service = {};

		var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth() + 1;

		// this promise has to be resolved before shell will load
		var curDef = $q.defer();
		var winDef = $q.defer();
		service.ready = $q.all([curDef.promise, winDef.promise]);

		service.curBattle = {};
		service.winners = [];
		
		// load current battle
		getSortedBattle(year, month).then(function(battle) {
			service.curBattle = battle;
			curDef.resolve();
		});

		// load previous winner battles
		$http.get('/api/battles/winners')
			.success(function(battles) {
				battles.forEach(function(b){
					b.restaurants = sortByVotes(b);
				});
				service.winners = battles;
				winDef.resolve();
			}
		);

    $rootScope.demoMode = null;  // demo mode code

		service.getDisplayMode = function () {
			if ($rootScope.demoMode) return $rootScope.demoMode;  // demo mode code
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
		};

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
			switch (service.getDisplayMode()) {
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

		service.nominate = function (yelpRest, comment) {
			var def = $q.defer();
			var config = {
				url: '/api/battles/nominate',
				method: 'POST',
				data: {
					nominate: {
						name: yelpRest.name,
						location: yelpRest.location.city,
						phone: yelpRest.display_phone,
						yelp_rating_photo_url: yelpRest.rating_img_url,
						yelp_photo_url: yelpRest.image_url,
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
//	params.require(:nominate).permit(:name, :location, :phone, :yelp_rating_photo_url, :yelp_photo_url, :comment)

		};

		/*  Private Functions  */

		function userVoted (numRestToCheck) {
			if (!UserService.user) return true;
			var uId = UserService.user.id;
			var n = numRestToCheck || service.curBattle.restaurants.length;
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
			});
			return deferred.promise;
		}

		return service;

	}]);

})();