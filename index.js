// Generated by CoffeeScript 1.6.3
var Index, cs;

(require('source-map-support')).install({
  handleUncaughtExceptions: false
});

cs = require('coffee-script');

module.exports = new (Index = (function() {
  var is_literate;

  function Index() {}

  Index.prototype.type = 'script';

  Index.prototype.name = 'coffee-script';

  Index.prototype.output = 'js';

  Index.prototype.ext = /\.(lit\.)?(coffee)(\.md)?$/m;

  Index.prototype.exts = ['.coffee', '.litcoffee', '.coffee.md'];

  is_literate = /\.(litcoffee|coffee\.md)$/m;

  Index.prototype.compile = function(filepath, source, debug, error, done) {
    var bare, compiled, err, js, literate, map, sourceMap;
    bare = 1;
    literate = is_literate.test(this.filepath);
    sourceMap = 1;
    if (literate) {
      source = source.replace(/^[^\s]+.+$/mg, '');
    }
    try {
      compiled = cs.compile(source, {
        bare: bare,
        sourceMap: sourceMap
      });
      js = compiled.js;
      map = JSON.parse(compiled.v3SourceMap);
    } catch (_error) {
      err = _error;
      return error(err);
    }
    return done(js, JSON.stringify(map, null, 2));
  };

  return Index;

})());
