const prometheus = require('prom-client');
const gcStats = require('prometheus-gc-stats');
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const express = require('express')
const _ = require('lodash')
const listen_port  = process.env.PORT || 9090
const forwarded_port = process.env.DST_PORT || 9099

var proxy = require('express-http-proxy');

require('prom-client/lib/defaultMetrics')();
const startGcStats = gcStats(prometheus.register); // gcStats() would have the same effect in this case
startGcStats();

const counter = new prometheus.Counter({
  name: 'companion_total',
  help: 'companion_total_help'
});

const histogram = new prometheus.Histogram({
  name: 'companion_histogram',
  help: 'companion_histogram_help',
  buckets: [0.1, 0.2, 0.3, 0.4, 0.5, 1, 10, 100]
});

const app = express()

app.get("/healthcheck", async function (req, res) {
  res.send("prom-companion-js")
})

app.get('/reload', async function (req, res) {
  const end = histogram.startTimer();
  console.log("reloading")
  try {
    const { stdout, stderr } = await exec("./synchronize.sh")
    counter.inc(); // Inc with 1
    end(); // Observes the value to xhrRequests duration in seconds
    res.send(stdout)
  } catch (e) {
    res.send("error:" + JSON.stringify(e))
  }
})

app.get('/companion/metrics', function (req, res) {
  console.log(`${Date.now()} - Fetching metrics...`)
  res.set('Content-Type', prometheus.register.contentType)
  return res.send(prometheus.register.metrics());
})

exec("./synchronize.sh")
  .then((res) => {
    console.log(res)
  })
  .catch((err) => {
    console.log(err)
  })



exec("curl http://169.254.169.254/latest/meta-data/local-ipv4", { timeout: 20000 })
  .then((response) => {
    console.log("response is --" + JSON.stringify(response) + "--")
    console.log("aws ip is --" + response.stdout + "--")
    app.use('/', proxy(`${response.stdout}:${forwarded_port}`))
  })
  .catch(err => {
    console.log("could not get aws local ip, using localhost")
    console.log(err)
    app.use('/', proxy(`localhost:${forwarded_port}`))
  })


app.listen(listen_port, function () {
  console.log(`Companion app listening on port ${listen_port}!`)
})

