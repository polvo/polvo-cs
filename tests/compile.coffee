should = require('chai').should()
coffee = require '..'

good_syntax = 'sum = (a, b)-> a + b'
bad_syntax = 'a = 1\n b = [\n c = 2'
literate_syntax = """
# A simple method

Do simple sums, with literate comments
in the file.
  
  sum = (a, b)->
    a + b
"""

describe '[polvo-cs]', ->

  it 'should compile code (also literate) and generate source maps', ->
    count = err: 0, out: 0
    error = -> count.err++
    done = (compiled, map)->
      count.out++
      map.should.not.be.undefined
      compiled.should.equal """var sum;

      sum = function(a, b) {
        return a + b;
      };

      """


    coffee.compile 'filename.coffee', good_syntax, false, error, done
    coffee.compile 'filename.litcoffee', literate_syntax, false, error, done
    coffee.compile 'filename.coffee.md', literate_syntax, false, error, done
    count.err.should.equal 0
    count.out.should.equal 3

  it 'should report syntax error and return an empty string', ->
    count = err: 0, out: 0
    error = (msg)->
      msg.name.should.equal 'SyntaxError'
      msg.location.first_line.should.equal 2
      msg.location.first_column.should.equal 6
      msg.location.last_line.should.equal 2
      msg.location.last_column.should.equal 6
      count.err++
    done = (compiled)->
      count.out++
      compiled.should.equal ''

    coffee.compile 'filename.coffee', bad_syntax, false, error, done
    count.err.should.equal 1
    count.out.should.equal 1