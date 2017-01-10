# Loopback Component Log

The loopback component add the log function to the loopback.


### Installation

1. Install in you loopback project:

  `npm install --save loopback-component-log`

2. Create a component-config.json file in your server folder (if you don't already have one)

3. Configure options inside `component-config.json`:

  ```json
  {
    "loopback-component-log": {
      "enabled": true,
      "name": "logger",
      "http": true,
      "level": "info",
      "useStdOut": true,
      "useLogFile": false,
      "path": "./logs"
      "maxResponseTime": 30000,
      "excludes": ["req","res"]
      ...
    }
  }
  ```
  - `enabled` *[Boolean]*: whether enable this component. *defaults: true*
  - `http` *[Boolean]*: whether log the http request. *defaults: true*
    * the Model.json can control it if not settings.
  - `level` *[String]*: the log level string: "trace", "debug", "info", "warn", error", "fatal". *defaults: "info"*
  - `useStdOut` *[Boolean]*: whether log to stdout. *defaults: true*
  - `useLogFile` *[Boolean]*: whether log to the file. *defaults: false*
    - `path` *[String]*: the log folder. *defaults: ./logs*
    - `period` *[String]*: the log file period. *defaults: 1d*
    - `logType` *[String]*: the log file type. *defaults: rotating-file*
    - `maxLogs` *[Integer]*: the max count of the log files. *default :10*
  - `maxResponseTime` *[Integer]*: treat if as fatal if response exceed the time. *default :30000*
    * 0 or null means do not enable this feature .
  - see the
    - [express-bunyan-logger](https://github.com/villadora/express-bunyan-logger)

### Usage

Just enable it on `component-config.json`.

```js
var loopback = require('loopback');
var rootlog = loopback.log;

rootlog.info("hi");
rootlog.warn({lang: 'fr'}, 'au revoir');
```

set `DEBUG=loopback:component:log` env vaiable to show debug info.

## History

## TODO

+ !syslog stream
