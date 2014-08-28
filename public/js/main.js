var app = angular.module('registrasi', []);


app.controller('registerCtrl', function($scope, $http) {
  $scope.input = {};
  $scope.success = false;
  $scope.loading = false;

  $scope.register = function() {
    $scope.loading = true;
    $http({
      method: 'POST',
      url: '/register',
      data: $.param($scope.input),
      headers: { 'Content-Type' : 'application/x-www-form-urlencoded' }
    })
    .success(function( data ) {
      if(data.error) {
        $scope.err = {};
        var error = data.error;
        for(i=0;i < error.length;i++) {
          var _a = error[i];
          $scope.err[_a.param] = _a.msg;
        }
      } else {
        $scope.success = true;
        $scope.err = {};
      }
      $scope.loading = false;
    })
    .error(function( err ) {
      console.log(err);
      $scope.loading = false;
    });
  };

});
