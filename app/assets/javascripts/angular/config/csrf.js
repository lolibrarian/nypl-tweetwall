// Appends the Cross-Site Request Forgery token to all outgoing requests.
app.config(function ($httpProvider) {
  var authToken = document.getElementsByName('csrf-token')[0].content;
  $httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = authToken;
});
