importScripts("https://www.gstatic.com/firebasejs/8.6.8/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.8/firebase-messaging.js");

firebase.initializeApp({
  
    apiKey: "AIzaSyCViwmkUMALKjPDy5mkNE3dpHmQMMZjXDY",
    authDomain: "getpassanywhere.firebaseapp.com",
    projectId: "getpassanywhere",
    storageBucket: "getpassanywhere.appspot.com",
    messagingSenderId: "1053605552026",
    appId: "1:1053605552026:web:9f4f1abe4f6a5f11886423",
    measurementId: "G-LQRN7MSEN5"
  
});
// For Firebase JS SDK v7.20.0 and later, measurementId is optional


const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});