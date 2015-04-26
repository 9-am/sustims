var changeView;

Template.addnew.helpers({
  options: [
    {
      value: 'college'
    }, {
      value: 'school'
    }, {
      value: 'office'
    }, {
      value: 'device'
    }
  ],
  selected: $('#ops-type').value
});

Template.addnew.events({
  'change #ops-type': function(event, template) {
    switch ($(event.target).val()) {
      case 'college':
        Session.set('showCollegeForm', true);
        Session.set('showSchoolForm', false);
        Session.set('showOfficeForm', false);
        Session.set('showDeviceForm', false);
        break;
      case 'school':
        Session.set('showSchoolForm', true);
        Session.set('showCollegeForm', false);
        Session.set('showOfficeForm', false);
        Session.set('showDeviceForm', false);
        break;
      case 'office':
        Session.set('showOfficeForm', true);
        Session.set('showCollegeForm', false);
        Session.set('showSchoolForm', false);
        Session.set('showDeviceForm', false);
        break;
      case 'device':
        Session.set('showDeviceForm', true);
        Session.set('showCollegeForm', false);
        Session.set('showSchoolForm', false);
        Session.set('showOfficeForm', false);
    }
    return changeView(this, template);
  }
});

changeView = function(list, template, changeTo) {
  return Tracker.flush();
};

Template.addnew.showCollegeForm = function() {
  return Session.get("showCollegeForm");
};

Template.addnew.showSchoolForm = function() {
  return Session.get("showSchoolForm");
};

Template.addnew.showOfficeForm = function() {
  return Session.get("showOfficeForm");
};

Template.addnew.showDeviceForm = function() {
  return Session.get("showDeviceForm");
};
