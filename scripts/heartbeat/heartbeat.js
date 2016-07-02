var firebase = require('firebase');
var macaddress = require('macaddress');
var diskspace = require('diskspace');
var async = require('async');

var firebaseConfig = {
    databaseURL: 'https://footstep-wsn-prod.firebaseio.com/'
};

firebase.initializeApp(firebaseConfig);

var count = 0;

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
    data['timestamp'] = new Date().toString();
    firebase.database().ref('testData/test1').update(data).then(function(){
      // TODO: fix logging!!
      console.log("done publishing");
    }).catch(function(){
      console.log("failed to publish");
    });
  });
}, 5000);
