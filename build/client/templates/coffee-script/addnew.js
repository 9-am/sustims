var Check, Save, _isACollegeHasSchools, changeView, getCollection;

this.CollegeList = new Meteor.Collection('college');

this.SchoolList = new Meteor.Collection('school');

this.OfficeList = new Meteor.Collection('office');

_isACollegeHasSchools = false;

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
  selected: $('#opsType').value,
  showCollegeForm: function() {
    return Session.get("showCollegeForm");
  },
  showSchoolForm: function() {
    return Session.get("showSchoolForm");
  },
  showOfficeForm: function() {
    return Session.get("showOfficeForm");
  },
  showDeviceForm: function() {
    return Session.get("showDeviceForm");
  },
  colleges: function() {
    return CollegeList.find({});
  },
  schools: function() {
    return SchoolList.find({});
  },
  hasSchool: function() {
    return _isACollegeHasSchools;
  }
});

Template.addnew.events({
  'change #college-selection-for-office': function(event, template) {
    Check.hasSchool(template);
    return Tracker.flush();
  },
  'change #opsType': function(event, template) {
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
  },
  'submit #addCollegeForm': function(event) {
    event.preventDefault();
    return Save.collegeInfo(event);
  },
  'submit #addSchoolForm': function(event, template) {
    event.preventDefault();
    return Save.schoolInfo(event, template);
  },
  'submit #addOfficeForm': function(event, template) {
    event.preventDefault();
    return Save.officeInfo(event, template);
  },
  'submit #addDeviceForm': function(event, template) {
    event.preventDefault();
    return Save.deviceInfo(event, template);
  }
});

changeView = function(list, template, changeTo) {
  return Tracker.flush();
};

Save = {
  collegeInfo: function(event1) {
    var id;
    this.event = event1;
    return id = CollegeList.insert({
      collegeName: this.event.target.collegeName.value
    });
  },
  schoolInfo: function(event1, template1) {
    var id, selectedCollege;
    this.event = event1;
    this.template = template1;
    selectedCollege = getCollection(this.template.find('#college-selection-for-school').value, CollegeList, 'college');
    return id = SchoolList.insert({
      collegeID: selectedCollege._id,
      schoolName: this.event.target.schoolName.value
    });
  },
  officeInfo: function(event1, template1) {
    var id, selectedCollege, selectedSchool;
    this.event = event1;
    this.template = template1;
    selectedCollege = getCollection(this.template.find('#college-selection-for-office').value, CollegeList, 'college');
    console.log(Check.hasSchool());
    if (Check.hasSchool()) {
      selectedSchool = getCollection(this.template.find('#school-selection-for-office').value, SchoolList, 'school');
      id = OfficeList.insert({
        collegeID: selectedCollege._id,
        schoolID: selectedSchool._id,
        officeName: this.event.target.officeName.value
      });
    } else {
      id = OfficeList.insert({
        collegeID: selectedCollege._id,
        officeName: this.event.target.officeName.value
      });
    }
    return console.log("done  " + id);
  },
  deviceInfo: function() {}
};

Check = {
  hasSchool: function(template1) {
    var schoolsOfCollege, selectedCollege;
    this.template = template1;
    selectedCollege = getCollection(this.template.find('#college-selection-for-office').value, CollegeList, 'college');
    console.log("found college : " + selectedCollege.collegeName);
    console.log("found college it's id is  : " + selectedCollege._id);
    schoolsOfCollege = SchoolList.find({
      "collegeID": "" + selectedCollege._id
    }).fetch();
    console.log(schoolsOfCollege);
    if (schoolsOfCollege.length > 0) {
      console.log('unlock Schools');
      return $('#school-selection-for-office').show();
    } else {
      console.log('no schools there');
      return $('#school-selection-for-office').hide();
    }
  }
};

getCollection = function(userSelection, Collect, collectionName) {
  var obj;
  this.userSelection = userSelection;
  obj = null;
  switch (collectionName) {
    case 'college':
      obj = Collect.findOne({
        collegeName: this.userSelection
      });
      break;
    case 'school':
      obj = Collect.findOne({
        schoolName: this.userSelection
      });
  }
  return obj;
};
