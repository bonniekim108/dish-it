(function() {
  'use strict';

  angular.module('app')

  .controller('SignupController', ['$http', '$state', 'UserService',
    // inject other services here
    function($http, $state, UserService) {
      var vm = this;
      vm.counties = [];

      // Lists out all counties from county list select field
      $http.get('api/counties').success(function(countydata){
      	vm.counties = countydata;
      });
			
			vm.submitForm = function(isValid) {
        if (isValid) {
        	UserService.signup(
        		  vm.signup.name,
	    		 		vm.signup.email,
	    		 		vm.signup.password,
	    		 		vm.signup.password_confirmation,
	    		 		vm.signup.county
	    		 	).then(function(user){
	    		 		$state.go('shell.about');
	    		 	},function(error){
	    		 		vm.errormsg = error;
	    		 	});
        }

      };

    }
    ]);

})();