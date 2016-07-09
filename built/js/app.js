(function() {
  'use strict';

  var globals = typeof window === 'undefined' ? global : window;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = ({}).hasOwnProperty;

  var endsWith = function(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
  };

  var _cmp = 'components/';
  var unalias = function(alias, loaderPath) {
    var start = 0;
    if (loaderPath) {
      if (loaderPath.indexOf(_cmp) === 0) {
        start = _cmp.length;
      }
      if (loaderPath.indexOf('/', start) > 0) {
        loaderPath = loaderPath.substring(start, loaderPath.indexOf('/', start));
      }
    }
    var result = aliases[alias + '/index.js'] || aliases[loaderPath + '/deps/' + alias + '/index.js'];
    if (result) {
      return _cmp + result.substring(0, result.length - '.js'.length);
    }
    return alias;
  };

  var _reg = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (_reg.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';
    path = unalias(name, loaderPath);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has.call(cache, dirIndex)) return cache[dirIndex].exports;
    if (has.call(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  require.register = require.define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  require.list = function() {
    var result = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  require.brunch = true;
  require._cache = cache;
  globals.require = require;
})();
require.register("game", function(exports, require, module) {
var assets, game, state;

state = require('state');

game = new Rogue.Game({
  fps: true,
  width: 800,
  height: 600
});

game.input = new Rogue.Keyboard(game.canvas);

game.mouse = new Rogue.Mouse(game);

game.assets = assets = new Rogue.AssetManager({
  baseUrl: "",
  packs: {
    core: [
      {
        name: "bg1",
        src: "img/b1.png"
      }, {
        name: "bg2",
        src: "img/b2.png"
      }, {
        name: "red",
        src: "img/1.png"
      }, {
        name: "blue",
        src: "img/2.png"
      }, {
        name: "jump",
        src: "sound/jump.ogg",
        alt: "sound/jump.mp3"
      }
    ]
  },
  preload: false
});

assets.on("load", "core", function(asset, percent) {
  return console.log("Assets loading: " + percent);
});

assets.on("complete", "core", function() {
  console.log("Assets loaded");
  return game.start(state);
});

assets.download("core");

module.exports = game;

});

require.register("initialize", function(exports, require, module) {

Rogue.ready(function() {
  return window.game = require('game');
});

});

require.register("state", function(exports, require, module) {
var state;

state = {
  setup: function(game) {
    var assets, bg1, bg2, tiles, x, _i, _ref, _results;
    console.log("setup run");
    assets = game.assets.core;
    this.viewport = new Rogue.ViewPort({
      parent: game,
      viewWidth: 1000,
      viewHeight: 400
    });
    bg1 = new Rogue.Entity({
      name: "bg1",
      image: assets.bg1,
      speed: 0.5,
      repeatX: true,
      require: ["layer"]
    });
    bg2 = new Rogue.Entity({
      name: "bg2",
      image: assets.bg2,
      speed: 0.9,
      repeatX: true,
      require: ["layer"]
    });
    game.player = new Rogue.Entity({
      name: "player",
      image: assets.blue,
      require: ["move", "collide", "AABB", "physics"]
    });
    game.player.behavior.add("gravity");
    game.player.ev.on("hit", function(col) {
      if (col.dir === "bottom") {
        return this.canJump = true;
      }
    });
    tiles = new Rogue.TileMap({
      name: "tiles",
      y: 300,
      size: [30, 1]
    });
    this.viewport.add([bg2, bg1, game.player, tiles]);
    this.viewport.updates.push(function() {
      this.follow(this.player);
      return this.forceInside(this.player, false);
    });
    _results = [];
    for (x = _i = 0, _ref = this.viewport.tiles.size[0]; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
      _results.push(this.viewport.tiles.place(new Rogue.Entity({
        image: assets.red,
        x: x,
        y: 0,
        require: ["sprite", "collide", "AABB"]
      })));
    }
    return _results;
  },
  update: function(game, dt) {
    var input, player;
    player = game.player;
    input = game.input;
    if (input.pressed("right")) {
      player.move(2, 0);
    }
    if (input.pressed("left")) {
      player.move(-2, 0);
    }
    if (input.pressed("up")) {
      if (player.canJump) {
        game.assets.core.jump.play();
        player.canJump = false;
        player.acc[1] = -25;
      }
    }
    if (input.pressed("down")) {
      player.move(0, 2);
    }
    return this.viewport.update(dt);
  },
  draw: function(game, dt) {
    game.clear();
    return this.viewport.draw();
  }
};

module.exports = state;

});


//# sourceMappingURL=app.js.map