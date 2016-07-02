var firebase = require('firebase');
var macaddress = require('macaddress');
var diskspace = require('diskspace');
var async = require('async');
var log4js = require('log4js');

var logfile = 'heartbeat';
log4js.loadAppender('file');
log4js.configure({
  appenders: [
    { type: 'console' },
    { type: 'file',
      filename: '../../logs/' + logfile + '.log',
      category: logfile,
      maxLogSize: 20480,
      backups: 10
    }
  ]
});

var logger = log4js.getLogger(logfile);
logger.setLevel("DEBUG");

var firebaseConfig = {
    databaseURL: 'https://footstep-wsn-prod.firebaseio.com/'
};

firebase.initializeApp(firebaseConfig);

setInterval(function(){
  async.waterfall([
    function(callback){
      diskspace.check('/', function (err, total, free, status){
        var data = {};
        data['disk_free'] = free / (1024 * 1024);
        data['disk_total'] = total / (1024 * 1024);
        callback(err, data);
      });
    },
    function(arg, callback){
      var data = arg || {};
      var iface = macaddress.networkInterfaces()["en0"];
      data['mac'] = iface["mac"];
      data['localip'] = iface["ipv4"];
      callback(null, data);
    },
    function(arg, callback){
      var data = arg || {};
      callback(null, data);
    }
  ], function(err, data){

    if(err){
      logger.error(err);
      return;
    }

    data['timestamp'] = new Date().toString();
    firebase.database().ref('testData/test1').update(data).then(function(){
      logger.info("Published data: " + JSON.stringify(data));
    }).catch(function(){
      logger.error("Failed to publish to Firebase");
    });
  });
}, 5000);
