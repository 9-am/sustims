Template.verticalbar.events
  'click .ti-plus':         () ->
    # GO -> addnew 
    Router.go 'addnew'
  'click .ti-blackboard':   () ->
    console.log 'browse was clicked'
  'click .ti-pie-chart':    () ->
    console.log 'reports was clicked'
  'click .ti-user':         () ->
    console.log 'users was clicked'
