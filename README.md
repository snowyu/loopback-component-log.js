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
      "name": 'logger',
      "http": true,
      "level": "info",
      "useStdOut": true,
      "maxResponseTime": 30000,
      "excludes": ["req","res"]
      ...
    }
  }
  ```
  - `enabled` *[Boolean]*: whether enable this component. *defaults: true*
  - `http` *[Boolean]*: whether log the http request. *defaults: true*
    * the Model.json can control it if not settings.
  - `maxResponseTime` *[Integer]*: treat if as fatal if response exceed the time. *default :30000*
    * 0 or null means do not enable this feature .
  - see the
    - [bunyan-log](https://github.com/sameke/bunyan-log)
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

