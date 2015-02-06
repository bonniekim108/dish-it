(function() {
  'use strict';

  angular.module('app')

  .controller('SignupController', ['$http',
    // inject other services here
    function($http) {
      var vm = this;
      vm.counties = [];
      $http.get('api/counties').success(function(data){
      	console.log(data)
      	vm.counties = data;

      });
			



      // Lists out all counties from county list select field
      // vm.counties = {};
			// vm.counties.options = [
			// 	{ id : 1, name: "Los Angeles County" },
			// 	{ id : 2, name: "Orange County" }
			// ];

			vm.submitForm = function(isValid) {
        if (isValid) {
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
