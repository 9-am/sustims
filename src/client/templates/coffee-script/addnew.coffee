Template.addnew.helpers {
  options: [
    {value: 'college'},
    {value: 'school'},
    {value: 'office'},
    {value: 'device'}
  ],
  selected: $('#ops-type').value
}
Template.addnew.events {
  'change #ops-type': (event, template) ->
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
      # alert @.
}
changeView = (list, template, changeTo)->

  # // force the template to redraw based on the reactive change
  Tracker.flush();
Template.addnew.showCollegeForm = ()->
  Session.get "showCollegeForm"
Template.addnew.showSchoolForm = ()->
  Session.get "showSchoolForm"
Template.addnew.showOfficeForm = ()->
  Session.get "showOfficeForm"
Template.addnew.showDeviceForm = ()->
  Session.get "showDeviceForm"
  # if @.options.selected = 'school'
  #   alert
  # switch @.options.value
  #   when 'college'
