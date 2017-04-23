var SoftwareDevelopmentNo5App = angular.module('SoftwareDevelopmentNo5App', []);

SoftwareDevelopmentNo5App.factory('game', function() {
  var CardNames = ['Ancientbooks', 'Dagger', 'Fan', 'Fazan', 'Horn', 'Ingot',
    'Jewelry', 'Mace'];
 
  return new Game(CardNames);

});
SoftwareDevelopmentNo5App.controller('GameCtrl', function GameCtrl($scope, game) {
    $scope.game = game;
    $scope.submit = function () {
        var CardNames = ['Ancientbooks', 'Dagger', 'Fan', 'Fazan', 'Horn', 'Ingot',
    'Jewelry', 'Mace'];

        return new Game(CardNames);
    };
});










