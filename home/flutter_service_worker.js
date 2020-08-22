'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "59721ad15d4607d0d8672f47f526a933",
"/": "59721ad15d4607d0d8672f47f526a933",
"main.dart.js": "4a354454799cb872b673856c93693772",
"index.css": "677e51b9418b74609cc07ff37d875b2d",
"favicon.png": "2b5d799d676b01d573ed413609423867",
"icons/Icon-192.png": "1a8740870fe9b66c8a40fb77bd398037",
"icons/Icon-512.png": "5c92afecc69217bc2b882808a96d474d",
"manifest.json": "deeb6e0db797c7824624eab69de346eb",
"assets/AssetManifest.json": "21b5343bc77bd44139801d26f8c0db74",
"assets/NOTICES": "5f401dbc49093e65d91d429f9c7e3537",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/lib/assets/locale/localization_en.json": "380b776be22808a4756261494e2a5f90",
"assets/lib/assets/locale/localization_ru.json": "5e87f36e85adad53569eb4c667579c1b",
"assets/lib/assets/images/payment.svg": "a4c218a794943eef1e1fd12db925f86c",
"assets/lib/assets/images/i_love_coding.jpg": "bfcc3ee6b862d018cf3823212dac931b",
"assets/lib/assets/images/android.svg": "0cfaad50e21b262d9074b6662915de3a",
"assets/lib/assets/images/firebase.svg": "1c415532b1999396ccad8b51a601e36e",
"assets/lib/assets/images/java.svg": "e6d87e2dca08c953fe3acd1275ed4f4e",
"assets/lib/assets/images/armenia.jpg": "3a7d5d4b69bdc1f355146820f0339d95",
"assets/lib/assets/images/profile_photo.jpg": "58fbdc79b439ce854f7b46eedf8d0916",
"assets/lib/assets/images/upwork_icon.svg": "f46b3d2158c72096c691d9a1bedefb46",
"assets/lib/assets/images/upwork_tile.svg": "8c3ebae497d5fe0a853c55641f4318cb",
"assets/lib/assets/images/flutter.svg": "c90c83c1db24b62692ed1a4c723f5312",
"assets/lib/assets/images/coffee_cup.svg": "9ea2c24532ea503f02362e7c94302aae",
"assets/lib/assets/images/emoji.svg": "ad2afc435e6fc7d5afcb861775dbc042",
"assets/lib/assets/images/time.svg": "f2375af1fc09a7db81a59945da5703b1",
"assets/lib/assets/images/apps.svg": "2d5d2926cf888db657dca0e8671a1bee",
"assets/lib/assets/images/upwork_ar21.svg": "86b514689b51625f809be89b5d85428c",
"assets/lib/assets/images/kotlin.svg": "d98b1be738cd1f56c161e3dc537e187a",
"assets/lib/assets/images/process.svg": "837705214965b976ff13b7311c88b4c4",
"assets/lib/assets/images/dart.svg": "cd152af676776ee8ed5aecf0ada2cf48",
"assets/lib/assets/images/google.svg": "5eb84e9a87acc82c0fcdd1991d48bf29",
"assets/lib/assets/images/rui_silva.jpg": "7d2eb4d70a845bdb5bfafb4a20959e6e",
"assets/lib/assets/images/profile.png": "54e9ec5365eeb967838ffd2a35eda50b",
"assets/lib/assets/images/google_maps.svg": "0871fa2949070cadd71b2233f346f210",
"assets/lib/assets/images/idea.svg": "26dc6a324b2b5f8dbbba62b535f4f82a",
"assets/lib/assets/images/phone.jpg": "38d8eaf719b1dc1602486a30e8e86734",
"assets/lib/assets/images/idea_1.svg": "7f98983aacf1111785bd7b7f89e64237",
"assets/lib/assets/images/conversation.svg": "21a4f0cd9e80aa5f5f5a26f973245655",
"assets/lib/assets/images/linkedin.svg": "d3df7f281394ed3357bb964a27caec52",
"assets/lib/assets/images/swift.svg": "a79776f392ad0be3aab28ebb12b627fa",
"assets/lib/assets/images/idea_2.svg": "7186454dc1f7409aa23109caa5206543",
"assets/lib/assets/images/profile_photo_dark.jpg": "bdb262c441d146dddc5bb94081723f6b",
"assets/lib/assets/images/ios_apple.svg": "60e1fadc2096f9f51eaedf9dd9dfc769",
"assets/lib/assets/images/swift_1.svg": "bc5830edda012cffdd415e489886ab0d",
"assets/lib/assets/images/gradle.svg": "d5ea82738bb6921daa9decf71b221cf7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
