'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f2bf9a34d8393409ddb2f809d82e197c",
"version.json": "088076da019b85d4b883e121b7b6ae71",
"favicon.ico": "0fd49867cbaeda013b15f6d2295cbdee",
"index.html": "e554f1109886a4da8669a51544ae8246",
"/": "e554f1109886a4da8669a51544ae8246",
"main.dart.js": "c7987e9e2b98bae9ff8a5eeaf6f577de",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"icons/apple-touch-icon.png": "fc8ae8f45de7b7f0db4f73da07628fbf",
"icons/icon-192.png": "1698a69f886b6bd17be88b1c81454e6a",
"icons/icon-192-maskable.png": "0d3d52031d12922da4354e00a2a92698",
"icons/icon-512-maskable.png": "58f2f2e00fd5e83c96745d49b85e72d1",
"icons/icon-512.png": "290a7b55bda99eb47bb921a7fea0999e",
"manifest.json": "b271f1c06f086ac9a53f20e61168a2b1",
"assets/AssetManifest.json": "0740bdef895833c7df6bde3253cc4e58",
"assets/NOTICES": "002712fa70baa27abe5e35f33e18013e",
"assets/FontManifest.json": "4c5fd63b76910e24457cfddf9d931415",
"assets/AssetManifest.bin.json": "0d72c5b05d2e69770b2a6c84d864dc01",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "dbc3418f2c069ca186680b5646a6eb5b",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/packages/flutter_boxicons/fonts/Boxicons.ttf": "20b1c3156a97064740efd925bba76770",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/src/pdf/support/Tratamiento-de-Datos.pdf": "ed65f150caa79af97f42b6657251b121",
"assets/lib/src/img/home/Bag&paint.png": "9360a241d0ec51fceba83d7778016394",
"assets/lib/src/img/home/Mosquera.png": "a73e452df3a26dd943c44fe8d35167f3",
"assets/lib/src/img/home/RosaSharon_Shoshana3.png": "a701c0fbedeb71c3f9674a8bb007dcc6",
"assets/lib/src/img/home/recommended2.jpg": "2ac13603507f794193cbcb82b1abc4f2",
"assets/lib/src/img/home/recommended3.jpg": "bbe2258ec65e3b5742a378d9ad6cb0e9",
"assets/lib/src/img/home/recommended1.jpg": "8bafeaa6785ca98e59dae35b2d78a39a",
"assets/lib/src/img/home/Servicios.jpg": "e4c71c3286ccc973ea37604ddc399144",
"assets/lib/src/img/home/RosaSharon_Jade.webp": "3dc77b7ceb8aa6c1bb6310facd0d51c3",
"assets/lib/src/img/home/Packvision.png": "647001976e3e9b618e8c16d1e1e27038",
"assets/lib/src/img/home/Calidad.jpg": "580ae45113747c8537bcff8b82c65374",
"assets/lib/src/img/home/Cumplimiento.jpg": "0e5b010f6d1e785ad3165494d9d4a427",
"assets/lib/src/img/home/Carvajal.png": "f50154fb37f23cd2346f650dc45d4b85",
"assets/lib/src/img/home/Norte.png": "1e329026f432bbd17a1dadd3737c973b",
"assets/lib/src/img/home/RosaSharon_Shoshana.webp": "8dbedb5a4ab272b80b321890ae196c72",
"assets/lib/src/img/home/Asesoria.jpg": "bf79e56165f6fa34a938ab4db4da4120",
"assets/lib/src/img/BImagotipo.png": "6c1daa8393eb60dcaf11b0797cfa8ff5",
"assets/lib/src/img/us/vision.jpg": "bae8d2acf349290071457975aeec2e36",
"assets/lib/src/img/us/us.png": "a9d77afd5da1d07a1211751db926b3a2",
"assets/lib/src/img/us/banner.png": "428808a403130162256449dd6f7c1a3e",
"assets/lib/src/img/us/mision.jpg": "eaa43a0b920149b2d9c24cb10261db67",
"assets/lib/src/img/404.png": "a86f904060cdd3e9f1a1b5c55bc2b0e2",
"assets/lib/src/img/WLogo.png": "5d9de6f9f2f182c83669f2b5cf1c2266",
"assets/lib/src/img/BLogo.png": "58df954182985583dbf924f818d2481b",
"assets/lib/src/img/BIsotipo.png": "582b6d16374cad9b40b071220f1f0ed2",
"assets/lib/src/img/WImagotipo.png": "476fb7c0a8deec1dedd661d6e74fe178",
"assets/lib/src/img/WIsotipo.png": "a2ca1b01b251f530f708636374c81a7d",
"assets/lib/src/img/support/PSE.png": "2f89af294c65dc721ca8a2135403188c",
"assets/lib/src/img/support/Nequi.png": "69db9b6ff83e28f30d1675f085480cbe",
"assets/lib/src/img/support/Diners.webp": "5eddd38f6079bd374aea51b8373f68bf",
"assets/lib/src/img/support/support_home.png": "63dab35aa6ab5ed2cb4d28f5e3d05e47",
"assets/lib/src/img/support/Visa.png": "0df6b7e29156936cb64cc7be1561f38e",
"assets/lib/src/img/support/Customer_Service.png": "9fde286ad0dbfd227e9ab24f59d25b31",
"assets/lib/src/img/support/Wompi.png": "c2540021e8a860b5c800245f9fcea46c",
"assets/lib/src/img/support/Daviplata.webp": "e9bd42a273d85841df830f5de621ff48",
"assets/lib/src/img/support/support_chat.png": "8c811a14f651fe863efcf59c9bcf2b1e",
"assets/lib/src/img/support/dataproccesing.png": "68090ff5606e4adf9b95fbb47ee7c56d",
"assets/lib/src/img/support/Adviser4.png": "c8bb00423b462ab280ca2e9b3cd23351",
"assets/lib/src/img/support/Adviser1.png": "0735b2413bd879b86986dd47fb027366",
"assets/lib/src/img/support/Adviser3.png": "d3aa218d7b4c70cca41e8208453d5346",
"assets/lib/src/img/support/American_express.png": "da034fc9bc0926ff85219413ff3b8baa",
"assets/lib/src/img/support/Adviser2.png": "c2fc15fd7cfcf632e962bff943d23afa",
"assets/lib/src/videos/catalog/backgroundus.mp4": "448b69cda914905ee7d8258d5c119460",
"assets/lib/src/fonts/D-DINExp-Bold.ttf": "fa367cc45817f512ff9da4d3b817561c",
"assets/lib/src/fonts/D-DINExp.ttf": "41ffa9abf903d51fdaabc3e27cb87273",
"assets/AssetManifest.bin": "3662d4a9f44be4279b490f80d41e69c0",
"assets/fonts/MaterialIcons-Regular.otf": "23e855e80bd135db013eb3484d96526e",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
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
