// Generated by CoffeeScript 1.7.1
(function() {
  var BodyScroll, defaults, userInteraction;

  defaults = {
    duration: 800,
    easing: 'swing',
    callback: null,
    offsetY: 0
  };

  userInteraction = "scroll mousedown DOMMouseScroll mousewheel keyup";

  BodyScroll = (function() {
    function BodyScroll(options) {
      this._options = $.extend({}, defaults, options);
      this._$body = $("html, body");
      this._animating = false;
      this._onUserInteraction = $.proxy(this._onUserInteraction, this);
      this._setup();
      this._animate();
    }

    BodyScroll.prototype._onUserInteraction = function() {
      this._$body.stop();
      this._animationEnd(false);
    };

    BodyScroll.prototype._setup = function() {
      this._$body.on(userInteraction, this._onUserInteraction);
    };

    BodyScroll.prototype._animationEnd = function(completed) {
      var _base;
      if (!this._animating) {
        return;
      }
      this._animating = false;
      this._$body.unbind(userInteraction, this._onUserInteraction);
      if (typeof (_base = this._options).callback === "function") {
        _base.callback(completed);
      }
    };

    BodyScroll.prototype._animate = function() {
      var offsetY;
      this._animating = true;
      offsetY = this._options.offsetY;
      if (window.scrollY > offsetY) {
        this._$body.animate({
          scrollTop: offsetY
        }, this._options.duration, this._options.easing, (function(_this) {
          return function() {
            _this._animationEnd(true);
          };
        })(this));
      }
    };

    return BodyScroll;

  })();

  $.bodyScroll = function(options) {
    return new BodyScroll(options);
  };

}).call(this);
