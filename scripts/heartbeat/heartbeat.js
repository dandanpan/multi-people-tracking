var firebase = require('firebase');

var firebaseConfig = {
    databaseURL: 'https://footstep-wsn-prod.firebaseio.com/'
};

firebase.initializeApp(firebaseConfig);

var count = 0;

setInterval(function(){
  firebase.database().ref('testData/test1').set({
    'name': 'shijia',
    'data' : count++
  }).then(function(){
    console.log("done publishing");
  }).catch(function(){
    console.log("failed to publish");
  });
}, 5000);
