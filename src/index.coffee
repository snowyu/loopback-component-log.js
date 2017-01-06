'use strict'
debug = require('debug')('loopback:component:log')
logger = require './logger'

module.exports = (app, options) ->
  debug 'initializing component'
  loopback = app.loopback
  loopbackMajor = loopback and loopback.version and loopback.version.split('.')[0] or 1
  if loopbackMajor < 2
    throw new Error('loopback-component-log requires loopback 2.0 or newer')

  if !options or options.enabled isnt false
    logger(app, options)
  else
    debug 'component not enabled'
