importScripts("https://www.gstatic.com/firebasejs/9.17.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.17.1/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "",
  authDomain: "",
  projectId: "",
  storageBucket: "rchat-c795d.firebasestorage.app",
  messagingSenderId: "95170494i4209",
  appId: "",
  measurementId: "G-ZH7DDDCT4iJ"
});

const messaging = firebase.messaging();

// Background message handler
messaging.onBackgroundMessage((payload) => {
  console.log("[firebase-messaging-sw.js] Received background message ", payload);

  const notificationTitle = payload.notification?.title || "MyTrader";
  const notificationOptions = {
    body: payload.notification?.body || "You have a new notification",
    icon: "/icons/Icon-192.png",
    badge: "/icons/Icon-192.png",
    vibrate: [200, 100, 200],
    tag: payload.data?.tag || "notification-tag",
    requireInteraction: false,
    data: {
      url: payload.data?.click_action || "/",
      ...payload.data
    }
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

// Handle notification clicks
self.addEventListener('notificationclick', (event) => {
  console.log('[firebase-messaging-sw.js] Notification click received.');

  event.notification.close();

  // Get the URL to open
  const urlToOpen = event.notification.data?.url || '/';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true })
      .then((clientList) => {
        // Check if there's already a window/tab open
        for (let i = 0; i < clientList.length; i++) {
          const client = clientList[i];
          if (client.url.includes(self.registration.scope) && 'focus' in client) {
            return client.focus().then(() => {
              // Navigate to the URL if needed
              if (urlToOpen !== '/') {
                client.postMessage({
                  type: 'NOTIFICATION_CLICK',
                  url: urlToOpen
                });
              }
            });
          }
        }
        // If no window is open, open a new one
        if (clients.openWindow) {
          return clients.openWindow(urlToOpen);
        }
      })
  );
});

// Handle push events (for browsers that don't use onBackgroundMessage)
self.addEventListener('push', (event) => {
  console.log('[firebase-messaging-sw.js] Push received.');
  
  if (event.data) {
    try {
      const payload = event.data.json();
      console.log('[firebase-messaging-sw.js] Push data:', payload);
      
      const notificationTitle = payload.notification?.title || "MyTrader";
      const notificationOptions = {
        body: payload.notification?.body || "You have a new notification",
        icon: "/icons/Icon-192.png",
        badge: "/icons/Icon-192.png",
        vibrate: [200, 100, 200],
        tag: payload.data?.tag || "notification-tag",
        data: {
          url: payload.data?.click_action || "/",
          ...payload.data
        }
      };

      event.waitUntil(
        self.registration.showNotification(notificationTitle, notificationOptions)
      );
    } catch (error) {
      console.error('[firebase-messaging-sw.js] Error parsing push data:', error);
    }
  }
});