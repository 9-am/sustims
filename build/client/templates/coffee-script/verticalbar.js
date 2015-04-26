Template.verticalbar.events({
  'click .ti-plus': function() {
    return Router.go('addnew');
  },
  'click .ti-blackboard': function() {
    return console.log('browse was clicked');
  },
  'click .ti-pie-chart': function() {
    return console.log('reports was clicked');
  },
  'click .ti-user': function() {
    return console.log('users was clicked');
  }
});
