# Scroll body to position, but halt when user scrolls
do ($ = jQuery, window, document) ->

  pluginName = "bodyScroll"
  defaults =
    duration: 800,
    easing: 'swing'
    callback: null
    offsetY: 0

  userInteraction = "scroll mousedown DOMMouseScroll mousewheel keyup"


  class BodyScroll
    constructor: (options) ->
      @_options = $.extend {}, defaults, options
      @_$body = $("html, body");

      @_animating = false
      @_onUserInteraction = $.proxy @_onUserInteraction, this

      @_setup()

      @_animate()

    _onUserInteraction: ->
      @_$body.stop()
      @_animationEnd()

      return

    _setup: ->
      @_$body.on userInteraction, @_onUserInteraction
      return
    _animationEnd: ->
      return unless @_animating
      @_animating = false

      @_$body.unbind userInteraction, @_onUserInteraction

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


