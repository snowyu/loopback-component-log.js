bunyan      = require 'bunyan'
expresslog  = require 'express-bunyan-logger'
mkdirp      = require 'mkdirp'
path        = require 'path'
debug       = require('debug')('loopback:component:log')

module.exports = (aApp, aOptions = {}) ->
  http        = aOptions.http || true
  name        = aOptions.name || 'logger'
  level       = aOptions.level || 'info'
  excludes    = aOptions.excludes || ['req','res']
  format      = aOptions.format
  useStdOut   = aOptions.useStdOut || true
  useLogFile  = aOptions.useLogFile
  logPath     = aOptions.path || './logs'
  period      = aOptions.period || '1d'
  logType     = aOptions.type || 'rotating-file'
  maxLogs     = aOptions.maxLogs || 10
  maxResTime  = aOptions.maxResponseTime || 30000
  src         = aOptions.src || (process.env.NODE_ENV is 'development')

  ["http","src","maxLogs","type","period","path","useStdOut","useLogFile","excludes","format","maxResponseTime"].forEach (i)->
    delete aOptions[i]

  loopback    = aApp.loopback
  streams     = []

  if useLogFile
    logPath = path.resolve(logPath)
    mkdirp.sync(logPath)
    appId = process.env.WORKER_ID
    if appId?
        logPath = path.join(logPath, (name + '.' + appId + '.log'))
    else
        logPath = path.join(logPath, (name + '.log'))
    streams.push
      type: logType
      path: logPath
      level: level
      period: period
      count: maxLogs
  if useStdOut
    streams.push
      level: level,
      stream: process.stdout

  logOpts =
    name: name
    serializers: bunyan.stdSerializers
    streams: streams
    level: level
    src: src

  logOpts = Object.assign(logOpts, aOptions)

  rootLogger  = bunyan.createLogger(logOpts)

  loopback.log = rootLogger
  if http
    aOptions.logger = rootLogger
    aOptions.excludes = excludes
    aOptions.format = format if format
    if maxResTime
      aOptions.levelFn = (status, err, meta)->
        if meta["response-time"] > maxResTime
          "fatal"
        else if status >= 500
          "error"
        else if status >= 400
          "warn"
        else
          "info"

    log = expresslog.errorLogger aOptions
    aApp.use (req, res, next)->
      log null, req,res,next
      return
  return
