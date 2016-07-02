var firebase = require('firebase');
var macaddress = require('macaddress');

var firebaseConfig = {
    databaseURL: 'https://footstep-wsn-prod.firebaseio.com/'
};

firebase.initializeApp(firebaseConfig);

var count = 0;

setInterval(function(){
  var iface = macaddress.networkInterfaces()["en0"];
  firebase.database().ref('testData/test1').set({
    'name': 'shijia',
    'data' : count++,
    'mac': iface["mac"],
    'localip': iface["ipv4"]
  }).then(function(){
    // TODO: fix logging!!
    console.log("done publishing");
  }).catch(function(){
    console.log("failed to publish");
  });
}, 5000);
