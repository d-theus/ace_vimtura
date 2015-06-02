gulp = require('gulp')
fs = require('fs')
include = require('gulp-include')
coffee = require('gulp-coffee')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
rename = require('gulp-rename')
gulpif = require('gulp-if')

NODE_ENV='development'

gulp.task 'compile', ->
  gulp.src([
    'javascripts/ace/ace.js'
    'javascripts/ace/vim.js'
    'javascripts/ace_vimtura.coffee'])
    .pipe(include())
    .pipe(
      gulpif(/[.]coffee$/, coffee( bare: true )))
    .pipe(concat 'ace_vimtura.js')
    .pipe(gulp.dest 'ace_vimtura/' )
  renderers = (for name in fs.readdirSync('javascripts/renderers') when name.lastIndexOf('.coffee') > 0
    name.replace('.coffee', '')
  )
  for name in renderers
    gulp.src([
      "javascripts/renderers/vendor-#{name}.js"
      "javascripts/renderers/#{name}.coffee" ])
      .pipe(
        gulpif(/[.]coffee$/, coffee( bare: true )))
      .pipe(concat "#{name}.js")
      .pipe(gulp.dest 'ace_vimtura/renderers')

gulp.task 'default', ['compile']
