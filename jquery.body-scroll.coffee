# Scroll body to position, but halt when user scrolls

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
    @_animationEnd false

    return

  _setup: ->
    @_$body.on userInteraction, @_onUserInteraction
    return
  _animationEnd: (completed) ->
    return unless @_animating
    @_animating = false

    @_$body.off userInteraction, @_onUserInteraction

    @_options.callback?(completed)

    return


  _animate: ->
    @_animating = true

    @_$body.animate(
      { scrollTop: @_options.offsetY }
      , @_options.duration
      , @_options.easing
      , =>
        @_animationEnd true
        return
    )

    return

$.bodyScroll = (options) ->
  new BodyScroll options


