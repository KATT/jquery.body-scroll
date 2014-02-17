# Scroll body to position, but halt when user scrolls
do ($ = jQuery, window, document) ->

  pluginName = "bodyScroll"
  defaults =
    duration: 800,
    easing: 'swing'
    callback: null
    offsetY: 0

  # The actual plugin constructor
  class BodyScroll
    constructor: (options) ->
      @_options = $.extend {}, defaults, options
      @_$body = $("html, body");

      @_animating = false

      @_setup()

      @_animate()

    _setup: ->
      @_$body.on "scroll mousedown DOMMouseScroll mousewheel keyup", =>
        @_$body.stop()
        @_animationEnd()
        return
      return
    _animationEnd: ->
      return unless @_animating
      @_animating = false

      @_$body.off "scroll mousedown DOMMouseScroll mousewheel keyup"

      @_options.callback?()

      return


    _animate: ->
      @_animating = true
      offsetY = @_options.offsetY
      if window.scrollY > offsetY
        @_$body.animate {scrollTop:offsetY}, @_options.duration, @_options.easing, => @_animationEnd()

      return

  $.bodyScroll = (options) ->
    new BodyScroll options


