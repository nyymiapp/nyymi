$( document ).ready(function() {
$( "#create_application_button" ).click(function() {
  $( "#send_application_form" ).slideDown( "slow", function() {
    // Animation complete.
  });
});
$( "#create_experience_button" ).click(function() {
  $( "#create_experience_form" ).slideDown( "slow", function() {
    // Animation complete.
  });
});
$('#experience_place').on('change', function() {
  if(this.value == "työ" || this.value == "vapaaehtoistyö" || this.value=="luottamustoimi"){
    $( "#experience_strictplace" ).slideDown( "slow", function() {
    // Animation complete.
    });
  } else {
    $( "#experience_strictplace" ).slideUp( "slow", function() {
    // Animation complete.
    });
  }
});
});
var appi = angular.module('apsyla', []);
appi.controller('MainCtrl', [
'$scope',
function($scope){
  $scope.application = {};
  $scope.application.freetext = " ";
  $scope.experience = {};
  $scope.experience.place = " ";
  $scope.experience.strictplace = " ";
  $scope.experiences = [];
  $scope.addExperience = function(){
    var experience = {
      place: $scope.experience.place,
      description: $scope.experience.des,
      start: $scope.experience.starting,
      end: $scope.experience.end, 
      strictplace: $scope.experience.strictplace
    }
  console.log(experience);
  $( "#experiences" ).append("kokemus " + $scope.experience.place + " tallennettu </br>");
   $scope.experiences.push(experience);
   $scope.experience.place = "";
   $scope.experience.des = "";
   $scope.experience.starting = "";
   $scope.experience.end = "";
   $scope.experience.strictplace = "";
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
      experiences: $scope.experiences
    }
     $.post('/applications', application).success(function(data, status) {
       
       localStorage.setItem("notification", "Hakemus luotu!");
        window.location = "/open_jobs";
     });
  };
   $scope.sendExperience = function(param_experience){
  $.post('/experiences', {experience: param_experience} ).success(function(data, status) {
    console.log("experience onnistui");
     });
  };
}]);