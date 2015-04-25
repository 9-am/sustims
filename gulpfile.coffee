###
  BIG WELCOME
    this configrations should be used to automate the project
  and update files to meteor project -> build folder.
  in case you are not agree with them feel free to do whatever
  you want .. by http://www.github.com/mohammedmatar
###
class ConfigMap
  src:         'src'
  srcStyle:    'src/style/style.scss'
  srcViews:    'src/client/**/*.jade'
  srcCoffeeTest:'src/**/*.coffee'
  dest:        ''
  destStyleEX: '/client/'
  destViewsEX: '/client/'
  development: on
  meteorite:   on
  init: ->
    if     @meteorite then @dest = 'build'
    else   @dest = 'src/devOut'
gulp   = require 'gulp'
sass   = require 'gulp-ruby-sass'
jade   = require 'gulp-jade'
concat = require 'gulp-concat'
coffee = require 'gulp-coffee'
gulp.task 'default', ->
  console.log 'running default task'
# ---------------------------- SASS  -----------------------------------------
gulp.task 'sass',    ->
  config = new ConfigMap()
  config.init()
  sass config.srcStyle#, { require: ['susy'] }
  .on 'error', (err) ->
    console.error '#ERROR', err.message
  .pipe gulp.dest config.dest+config.destStyleEX
# ---------------------------- JADE  -----------------------------------------
gulp.task  'jade',   ->
  config = new ConfigMap()
  config.init()
  gulp.src config.srcViews
  .pipe    jade()
  .on      'error', (err) ->
    console.error '#ERROR', err.message
  .pipe    gulp.dest config.dest+config.destViewsEX
gulp.task  'concat', ->
  gulp.src ''
# ---------------------------- COFFEE  -----------------------------------------
gulp.task 'coffee-test', ->
  config = new ConfigMap()
  config.init()
  gulp.src config.srcCoffeeTest
  .pipe coffee({bare:true})
  .on      'error', (err) ->
    console.error '#ERROR', err
  .pipe gulp.dest config.dest
# ---------------------------- WATCH  ------------------------------------------
gulp.task 'watch', ->
  config = new ConfigMap()
  config.init()
  # watch style files changes
  console.log 'start watching sass files'
  gulp.watch 'src/style/**/*.scss', ['sass']
  # watch jade files changes
  console.log 'satrt watching jade files'
  gulp.watch config.srcViews, ['jade']
  # watch coffeescript files changes
  console.log 'start watching coffescript files'
  gulp.watch  config.srcCoffeeTest, ['coffee-test']
# ---------------------------- THE-END  ----------------------------------------
