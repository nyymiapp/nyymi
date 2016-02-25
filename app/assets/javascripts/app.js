angular.module('äpsylä', [])
.controller('MainCtrl', [
'$scope',
function($scope){

  $scope.application = {};
  $scope.application.freetext = " ";

  $scope.experience = {};
  $scope.experience.place = " ";

  $scope.experiences = [];

  $scope.addExperience = function(){
  	var experience = {
    	place: $scope.experience.place,
    	description: $scope.experience.description,
    	start: $scope.experience.start,
    	end: $scope.experience.end
	}
	$( "#experiences" ).append("kokemus " + $scope.experience.place + " tallennettu");
	 $scope.experiences.push(experience);
	 $scope.experience.place = "";
	 $scope.experience.description = "";
	 $scope.experience.start = "";
	 $scope.experience.end = "";
	 console.log( $scope.experiences);

	  $( "#create_experience_form" ).slideToggle( "slow", function() {
    // Animation complete.
  	  });
  };

  $scope.sendApplication = function(){
  	$scope.open_job_id=(/open_jobs\/(\d+)/.exec(window.location.href)[1]);

  	if(angular.isUndefined($scope.application.freetext) || $scope.application.freetext === null){
  		$scope.application.freetext = "";
  	}

  	var application = {
    	freetext: $scope.application.freetext,
    	open_job_id: $scope.open_job_id, 
	}

	$.post('/applications', application).success(function(data, status) {

             for (var i in $scope.experiences) {
  				$scope.sendExperience($scope.experiences[i]);
			 }
			 localStorage.setItem("notification", "Application created!");
             window.location = "/open_jobs";
     });
  };

   $scope.sendExperience = function(experience){

	$.post('/experiences', experience).success(function(data, status) {
		console.log("experience onnistui");
     });
  };

}]);