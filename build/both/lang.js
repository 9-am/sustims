var getUserLanguage;

getUserLanguage = function() {
  return 'en';
};

if (Meteor.isClient) {
  Meteor.startup(function() {
    Session.set("showLoadingIndicator", true);
    return TAPi18n.setLanguage(getUserLanguage()).done(function() {
      return Session.set("showLoadingIndicator", false);
    }).fail(function(error_message) {
      return console.log(error_message);
    });
  });
}
