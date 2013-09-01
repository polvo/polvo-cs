(require 'source-map-support').install
  handleUncaughtExceptions: false

cs = require 'coffee-script'

module.exports = new class Index

  type: 'script'
  name: 'coffee-script'
  output: 'js'

  ext: /\.(lit)?(coffee)(\.md)?$/m
  exts: ['.coffee', '.litcoffee', '.coffee.md']

  is_literate = /\.(litcoffee|coffee\.md)$/m

  compile:( filepath, source, debug, error, done )->
    bare = 1
    sourceMap = 1

    if is_literate.test filepath
      source = source.replace /^[^\s\t].+$/gm, ''

    try
      compiled = cs.compile source, {bare, sourceMap}

      js = compiled.js
      map = JSON.parse compiled.v3SourceMap
    catch err
      done ''
      return error err

    done js, (JSON.stringify map, null, 2)