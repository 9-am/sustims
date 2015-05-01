@CollegeList = new Meteor.Collection 'college'
@SchoolList  = new Meteor.Collection 'school'
@OfficeList  = new Meteor.Collection 'office'
_isACollegeHasSchools = false
Template.addnew.helpers {
  options: [
    {value: 'college'},
    {value: 'school'},
    {value: 'office'},
    {value: 'device'}
  ]
  selected: $('#opsType').value
  showCollegeForm : ()->
    Session.get "showCollegeForm"
  showSchoolForm  : ()->
    Session.get "showSchoolForm"
  showOfficeForm  : ()->
    Session.get "showOfficeForm"
  showDeviceForm  : ()->
    Session.get "showDeviceForm"
  # RETRIVE DATA FROM DATABASE
  colleges: () ->
    CollegeList.find({})
  schools:  () ->
    SchoolList.find({})
  hasSchool:() ->
    _isACollegeHasSchools
}
Template.addnew.events {
  'change #college-selection-for-office': (event, template) ->
    Check.hasSchool(template)
    Tracker.flush();
  'change #opsType': (event, template) ->
    # tempValue = $(event.target).val()
    switch $(event.target).val()
      when  'college'
        Session.set('showCollegeForm', true);
        Session.set('showSchoolForm',  false);
        Session.set('showOfficeForm',  false);
        Session.set('showDeviceForm',  false);
      when  'school'
        Session.set('showSchoolForm',  true);
        Session.set('showCollegeForm', false);
        Session.set('showOfficeForm',  false);
        Session.set('showDeviceForm',  false);
      when  'office'
        Session.set('showOfficeForm',  true);
        Session.set('showCollegeForm', false);
        Session.set('showSchoolForm',  false);
        Session.set('showDeviceForm',  false);
      when  'device'
        Session.set('showDeviceForm',  true);
        Session.set('showCollegeForm', false);
        Session.set('showSchoolForm',  false);
        Session.set('showOfficeForm',  false);

    changeView(@, template)
  'submit #addCollegeForm':  (event) ->
    # be sure that browser won't refresh after submiting
    event.preventDefault();
    Save.collegeInfo(event);
  'submit #addSchoolForm':  (event, template) ->
    event.preventDefault();
    Save.schoolInfo(event, template);
  'submit #addOfficeForm':  (event, template) ->
    event.preventDefault();
    Save.officeInfo(event, template);
  'submit #addDeviceForm':  (event, template) ->
    event.preventDefault();
    Save.deviceInfo(event, template);
}
changeView = (list, template, changeTo) ->
                Tracker.flush();
# Collection of save operations
Save = {
  # should save college info's to database
  collegeInfo : (@event) ->
    id = CollegeList.insert {
      collegeName:  @event.target.collegeName.value
    }
  schoolInfo  : (@event, @template) ->
    selectedCollege = getCollection @template.find('#college-selection-for-school').value, CollegeList, 'college'
    id = SchoolList.insert {
      collegeID:    selectedCollege._id
      schoolName:   @event.target.schoolName.value
    }
  officeInfo  : (@event, @template) ->
    selectedCollege = getCollection @template.find('#college-selection-for-office').value, CollegeList, 'college'
    console.log Check.hasSchool()
    if Check.hasSchool()
      selectedSchool  = getCollection @template.find('#school-selection-for-office').value, SchoolList, 'school'
      id = OfficeList.insert {
        collegeID :  selectedCollege._id
        schoolID  :  selectedSchool._id
        officeName:  @event.target.officeName.value
      }
    else
      id = OfficeList.insert {
        collegeID :  selectedCollege._id
        officeName:  @event.target.officeName.value
      }
    console.log "done  #{id}"
  deviceInfo  : () ->
  # force the template to redraw based on the reactive change
}
Check = {
  hasSchool: (@template) ->
    # console.log "start finding college #{@template}"
    selectedCollege = getCollection @template.find('#college-selection-for-office').value, CollegeList, 'college'
    console.log "found college : #{selectedCollege.collegeName}"
    console.log "found college it's id is  : #{selectedCollege._id}"
    schoolsOfCollege= SchoolList.find({"collegeID" : "#{selectedCollege._id}"}).fetch()
    console.log schoolsOfCollege
    if  schoolsOfCollege.length > 0
      console.log 'unlock Schools'
      $('#school-selection-for-office').show()
      # _isACollegeHasSchools = true
    else
      console.log 'no schools there'
      $('#school-selection-for-office').hide()
    #   return false

}
# @argments
# id -> DOM element ID
# template -> html template
# Collect -> MongoDB collection
getCollection = (@userSelection, Collect, collectionName) ->
  obj = null
  switch collectionName
    when 'college'
      obj =  Collect.findOne {collegeName: @userSelection}
    when 'school'
      obj =  Collect.findOne {schoolName: @userSelection}
  return obj
