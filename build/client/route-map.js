Router.map(function() {
  return this.route('dashboard', {
    path: '/'
  }, this.route('addnew', {
    path: '/addnew'
  }));
});
