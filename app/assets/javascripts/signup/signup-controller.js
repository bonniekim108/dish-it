(function() {
  'use strict';

  angular.module('app')

  .controller('SignupController', [
    // inject other services here
    function() {
      var vm = this;

      // Lists out all counties from county list select field
      vm.counties = {};
      vm.badpw;
      vm.bademail;
			vm.counties.options = [
				{ id : 1, name: "Los Angeles County" },
				{ id : 2, name: "Orange County" }
			];

			vm.submitForm = function(isValid) {

        if (isValid) {
        	if (vm.signup.password != vm.signup.password_confirmation) {
        		vm.badpw = "Passwords do not match!";
        	}
        	// if (vm.signup.email == database.email) {
        	// 	vm.bademail = "User email already taken!";
        	// }
          console.log(vm.signup.name);
          console.log(vm.signup.email);
          console.log(vm.signup.password);
          console.log(vm.signup.password_confirmation);
          console.log(vm.signup.county);
        }

      };

    }
    ]);

})();