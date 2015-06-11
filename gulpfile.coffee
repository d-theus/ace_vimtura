gulp = require('gulp')
fs = require('fs')
include = require('gulp-include')
coffee = require('gulp-coffee')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
rename = require('gulp-rename')
gulpif = require('gulp-if')
less = require('gulp-less')

NODE_ENV='development'

gulp.task 'compile', ->
  gulp.src([
    'lib/ace/ace.js'
    'lib/ace/vim.js'
    'javascripts/ace_vimtura.coffee'
  ])
    .pipe(include())
    .pipe(
      gulpif(/[.]coffee$/, coffee( bare: true )))
    .pipe(concat 'ace_vimtura.js')
    .pipe(gulp.dest 'ace_vimtura/' )
  gulp.src('javascripts/main.coffee')
    .pipe(coffee bare: true)
    .pipe(gulp.dest 'ace_vimtura/')
  gulp.src('javascripts/utils/**/*.coffee')
    .pipe(coffee bare: true)
    .pipe(gulp.dest 'ace_vimtura/utils/')
  gulp.src([
    "javascripts/renderers/*.coffee"
  ])
    .pipe(include())
    .pipe(coffee bare: true )
    .pipe(gulp.dest 'ace_vimtura/renderers')
  gulp.src('stylesheets/**/*.less')
    .pipe(less())
    .pipe(concat 'ace_vimtura.css')
    .pipe(gulp.dest('ace_vimtura'))

gulp.task 'default', ['compile']
