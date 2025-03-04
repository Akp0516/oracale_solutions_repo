'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "41c1f39fb76c8833934263482c096166",
"version.json": "af3fa05ef7416c51126401db61d09290",
"index.html": "40a4b1582ce80af45a132b2b7957c77e",
"/": "40a4b1582ce80af45a132b2b7957c77e",
"netlify.toml": "211439430daecad4b5f48c6b7e043dd5",
"main.dart.js": "5f16c6ad6acd87ce77f75440ce294d7f",
"os_tab_logo.png": "3698b7e3d7beb5748d307b8ff0ce89fd",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1092ffb8dcc573fb9bd7be848a911861",
"assets/AssetManifest.json": "a09dde636e01734a8ea2008b4d4be207",
"assets/NOTICES": "43b0fb70286c386ca573d3367b2a3879",
"assets/FontManifest.json": "248dd1acdf75e48c351a7959a94a18cb",
"assets/AssetManifest.bin.json": "63347585016379074e6985f7332994ea",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ac1a5ccacaaab907dcb1dcc80d0a483a",
"assets/fonts/MaterialIcons-Regular.otf": "fdc82cc5650a9d4e8d9072a0a97d719d",
"assets/assets/images/WE-Image/Support.png": "6fe12f437b6c32f5a4b3aea1f76a7137",
"assets/assets/images/WE-Image/Abouy.jpg": "e089f66d27c5f807e10d927073e7d8ae",
"assets/assets/images/WE-Image/Custom.png": "1fac09c622c4a4dcf92bbcee878fcc9b",
"assets/assets/images/WE-Image/Banner.jpg": "936c0f46e24296e7ee50a44e97cafa16",
"assets/assets/images/WE-Image/Services.png": "66309c4f5446fe3ade6a85b7d57b7897",
"assets/assets/images/WE-Image/Footer.jpg": "5f264213428487112b74b19df2cdd3e2",
"assets/assets/images/WE-Image/Accoubnt.png": "1699f90aa4dcd818667e243dd6111e24",
"assets/assets/images/WE-Image/Setup.png": "112c8c6e5704f550dfd8e5863edb371f",
"assets/assets/images/WE-Image/Mannagment.png": "8d8173831d01a0f9d38d6223eb28333d",
"assets/assets/images/WE-Image/Solutions.jpg": "81d0663e39369cb3d03f2c7aa4f41895",
"assets/assets/images/WE-Image/Solution.png": "26dddf85198a0a6827c87f83a7b9e233",
"assets/assets/images/WE-Image/Cost.png": "286fa5569f497776b08c86f52aaabffa",
"assets/assets/images/logo.jpeg": "ab30117cdfd92f604517bbe46a80f37e",
"assets/assets/images/new_logo_withoutbg.png": "91215ce9663a241ab89c3c846c363eaf",
"assets/assets/images/new_logo.jpeg": "539a168bb3b4e24e0eb829cda4f5bf79",
"assets/assets/font/Montserrat-VariableFont_wght.ttf": "b87689f37dfb5c51719210e4d96a34a2",
"assets/assets/font/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/font/RobotoSlab-VariableFont_wght.ttf": "639c828487a32043addce04bdf807f24",
"assets/assets/font/PlayfairDisplay-VariableFont_wght.ttf": "5c26cb0a6cef324c460754822591bd93",
"assets/assets/font/Norican-Regular.ttf": "60f12a5c67e1a061dacaa37a09308f68",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
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
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
