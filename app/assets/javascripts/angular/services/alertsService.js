app.service('alertsService', function () {
  var currentAlerts = {};

  // Returns the current server error (if any).
  this.getServerError = function () {
    return currentAlerts.serverError;
  };

  // Sets the current server error.
  this.setServerError = function (status) {
    currentAlerts.serverError = status;
  };
});
