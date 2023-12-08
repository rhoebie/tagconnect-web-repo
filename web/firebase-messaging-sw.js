importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyDS2DFJN4t_VlugX8-ez2hABbpbe2x6LNM",
    authDomain: "tagconnect-ff743.firebaseapp.com",
    projectId: "tagconnect-ff743",
    storageBucket: "tagconnect-ff743.appspot.com",
    messagingSenderId: "39980717647",
    appId: "1:39980717647:web:45d51b3451516d9650fc3a",
    measurementId: "G-4RB162ZG06"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});