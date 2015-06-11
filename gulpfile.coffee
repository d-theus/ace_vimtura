gulp = require('gulp')
fs = require('fs')
coffee = require('gulp-coffee')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
rename = require('gulp-rename')
gulpif = require('gulp-if')
copy = require('gulp-copy')

NODE_ENV='development'

gulp.task 'compile',
  [
    'compile:renderers'
    'compile:main'
    'compile:ace_vimtura'
    'compile:preview'
    'compile:style'
    'copylib'
  ], ->

gulp.task 'compile:ace_vimtura', ->
  gulp.src([
    'lib/ace/ace.js'
    'lib/ace/vim.js'
    'javascripts/ace_vimtura.coffee'
  ])
    .pipe(gulpif(/[.]coffee$/, coffee( bare: true )))
    .pipe(concat 'ace_vimtura.js')
    .pipe(gulp.dest 'build/javascripts/' )

gulp.task 'compile:renderers', ->
  gulp.src("javascripts/renderers/*.coffee")
    .pipe(coffee bare: true )
    .pipe(gulp.dest 'build/javascripts/renderers/')

gulp.task 'compile:main', ->
  gulp.src('javascripts/main.coffee')
    .pipe(coffee bare: true)
    .pipe(gulp.dest 'build/javascripts' )

gulp.task 'compile:preview', ->
  gulp.src('javascripts/preview.coffee')
    .pipe(coffee bare: true)
    .pipe(gulp.dest 'build/javascripts' )


gulp.task 'copylib', ->
  gulp.src([
    'lib/**/*.js'
  ])
    .pipe(copy 'build/javascripts')

gulp.task 'compile:style', ->
  gulp.src('javascripts/style.coffee')
    .pipe(coffee())
    .pipe(gulp.dest 'build/javascripts')

gulp.task 'default', ['compile']
