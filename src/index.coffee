(require 'source-map-support').install
  handleUncaughtExceptions: false

cs = require 'coffee-script'

module.exports = new class Index

  polvo: true

  type: 'js'
  name: 'coffee-script'
  ext: /\.(lit\.)?(coffee)(\.md)?$/m
  exts: ['.coffee', '.litcoffee', '.coffee.md']

  LITERATE = /\.(litcoffee|coffee\.md)$/m

  compile:( filepath, source, done )->
    bare = 1
    literate = LITERATE.test @filepath
    sourceMap = 1

    source = source.replace /^[^\s]+.+$/mg, '' if literate

    try
      compiled = cs.compile source, {bare, sourceMap}
      
      js = compiled.js
      map = JSON.parse compiled.v3SourceMap

      done js, (JSON.stringify map, null, 2)
    catch err
      console.error err.message + ' at ' + @filepath
      done()