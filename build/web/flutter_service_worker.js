'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "dd92e0955ed15eadf67329b6e1a58717",
"/": "dd92e0955ed15eadf67329b6e1a58717",
"main.dart.js": "6b6a18cac7b64baa964464b700170ce5",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "ac0f53f8bdd79e39a2dd02a4944f2156",
"assets/LICENSE": "d2d3c5b598d1193a48694567c4a27ee9",
"assets/AssetManifest.json": "5d122b2871dfcde8e89bfa69bf02d23f",
"assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/lib/assets/locale/localization_en.json": "2e1b236dd4c47f11e70b57a6238fe3ca",
"assets/lib/assets/locale/localization_ru.json": "5e87f36e85adad53569eb4c667579c1b",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
