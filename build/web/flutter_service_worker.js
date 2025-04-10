'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "15d01bb0bf0c0b8d1169ced24ebd9f0d",
"version.json": "088076da019b85d4b883e121b7b6ae71",
"favicon.ico": "0fd49867cbaeda013b15f6d2295cbdee",
"index.html": "5714d825f1e61b571c654b88d5d2d545",
"/": "5714d825f1e61b571c654b88d5d2d545",
"main.dart.js": "f2ff0a9bd2baecdba056cdc8dfab6cda",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"icons/icon-192.webp": "67fa3a46b9f343c10491d17769f26dba",
"icons/apple-touch-icon.png": "fc8ae8f45de7b7f0db4f73da07628fbf",
"icons/apple-touch-icon.webp": "f1c38038a3b8fc8a6479e57878671566",
"icons/icon-192.png": "1698a69f886b6bd17be88b1c81454e6a",
"icons/icon-512-maskable.webp": "b072be322842d9bccb4f1b167fbbffd0",
"icons/icon-192-maskable.png": "0d3d52031d12922da4354e00a2a92698",
"icons/icon-512-maskable.png": "58f2f2e00fd5e83c96745d49b85e72d1",
"icons/icon-512.webp": "390f7eafa8947e0f4405ceeb2e9e05aa",
"icons/icon-192-maskable.webp": "79ddc238052cf4e8835719283b63ad0e",
"icons/icon-512.png": "290a7b55bda99eb47bb921a7fea0999e",
"manifest.json": "b271f1c06f086ac9a53f20e61168a2b1",
"assets/AssetManifest.json": "68cb3bf2ef648507efe6b86bfc43a582",
"assets/NOTICES": "002712fa70baa27abe5e35f33e18013e",
"assets/FontManifest.json": "4c5fd63b76910e24457cfddf9d931415",
"assets/AssetManifest.bin.json": "002ebb05c52c98340a6a685f8a716b7a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "dbc3418f2c069ca186680b5646a6eb5b",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/packages/flutter_boxicons/fonts/Boxicons.ttf": "20b1c3156a97064740efd925bba76770",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/src/pdf/support/Tratamiento-de-Datos.pdf": "ed65f150caa79af97f42b6657251b121",
"assets/lib/src/img/home/Norte.webp": "fbccc2cb61fefd65d2b90864abb3503f",
"assets/lib/src/img/home/RosaSharon_Shoshana3.webp": "876544a14d659e90fabe9e956fd1db4b",
"assets/lib/src/img/home/calidad.webp": "b9ccd7338f9ca450f21b381e5e376357",
"assets/lib/src/img/home/Bag&paint.webp": "282954d2bc4b378a60e58b9ce4ac81fa",
"assets/lib/src/img/home/RosaSharon_Jade.webp": "00a35f2994007d6870b7f728e9720718",
"assets/lib/src/img/home/servicios.webp": "49d6b0a16dad002d7f4187b037fdea91",
"assets/lib/src/img/home/Carvajal.webp": "ac8b361340784b9cea4052c8b9f4fcb1",
"assets/lib/src/img/home/Packvision.webp": "4cb58f54a2cf617195559897ac1f9691",
"assets/lib/src/img/home/RosaSharon_Shoshana.webp": "ea8695eb0fc6286ac1818a02cb220006",
"assets/lib/src/img/home/asesoria.webp": "888504e982b327d92ac5563c1b9dee8a",
"assets/lib/src/img/home/Mosquera.webp": "598dfce2d1362ddcd5467afa6e362f1c",
"assets/lib/src/img/home/cumplimiento.webp": "1b97faa4548c83c6d5cdf62eb385e263",
"assets/lib/src/img/us/us.webp": "e405146b063003a51546454dfd9ca50b",
"assets/lib/src/img/BLogo.webp": "3a1e79ae269d04b363386dbaf38010c6",
"assets/lib/src/img/ecobag/flowpack.webp": "c73451fe6cf84fbb1d50860193cc4948",
"assets/lib/src/img/ecobag/discover3.webp": "e43b8271c4aa564e67e9148466a9fd56",
"assets/lib/src/img/ecobag/discover2.webp": "e55a0788a806f48b8d86163eca6d8091",
"assets/lib/src/img/ecobag/cojin.webp": "610aef5a9ee56086ea5f9412619f7b05",
"assets/lib/src/img/ecobag/Ventana.webp": "53d8d054698b62131f7ca6a69baa36d6",
"assets/lib/src/img/ecobag/doypack.webp": "0d700dde2dae9d906ced65acb068b649",
"assets/lib/src/img/ecobag/Piramidal.webp": "ec1c81cfa9b61a2ea66760cbada412b5",
"assets/lib/src/img/ecobag/discover5.webp": "a1fcbe54bf89fe8e4431862726951e2b",
"assets/lib/src/img/ecobag/discover9.webp": "120e8fefd522d2dd0c5dd23cd1d720d9",
"assets/lib/src/img/ecobag/5pro.webp": "6a7264f73dda0b12b47ba8f0eb09b92e",
"assets/lib/src/img/ecobag/hoja1.webp": "72ec5fa3bd4b24e123f1093901eb0cd1",
"assets/lib/src/img/ecobag/discover8.webp": "711b64296bc3c8790876d2f4e6e997e4",
"assets/lib/src/img/ecobag/4pro.webp": "33cbd9ead4c7dbe419a1b2d3de2d035d",
"assets/lib/src/img/ecobag/discover4.webp": "6f7149403331e2a260806d8c18f0564a",
"assets/lib/src/img/ecobag/discover7.webp": "4e499df8f3565cd7d579936738f6a3cf",
"assets/lib/src/img/ecobag/hoja2.webp": "9c2445b9f494ee81c895f4043d6bc5ca",
"assets/lib/src/img/ecobag/hoja3.webp": "0326d59ccdd8510b92d0c07805fdd8de",
"assets/lib/src/img/ecobag/discover10.webp": "63252f51d84a710b61bde419bcfdb198",
"assets/lib/src/img/ecobag/discover6.webp": "4a006687d2efe5bc64e16ea2f1e5faaa",
"assets/lib/src/img/ecobag/discover1.webp": "fb43d18cf18c8aad3fff211f4b1aa99b",
"assets/lib/src/img/404.webp": "798645e945c3f7a7245247c7268bb9c4",
"assets/lib/src/img/WLogo.webp": "d09b8a78c660a47ecbcf73170ac9e6ec",
"assets/lib/src/img/support/Customer_Service.webp": "0c1e14ec685e58c2e0476f4e9dc4529f",
"assets/lib/src/img/support/dataproccesing.webp": "d0c8053427af7882aca828613187f909",
"assets/lib/src/img/support/Diners.webp": "2a65ee8692a7b30275bd5bd49416ea0a",
"assets/lib/src/img/support/PSE.webp": "1343e6157ebded5e6358ac8bf68dd922",
"assets/lib/src/img/support/support_home.webp": "7a113bb89eb7bc89ca773f35c0a04e1d",
"assets/lib/src/img/support/Adviser1.webp": "aa0668dedfcee861533ccdcafbce9a72",
"assets/lib/src/img/support/Daviplata.webp": "ca8787d6ca57994480316c0e389e6265",
"assets/lib/src/img/support/Adviser2.webp": "20add4794f58dd6603f01dc3e42c33f9",
"assets/lib/src/img/support/Nequi.webp": "774f1966f55d45b24202bcc47785e6d9",
"assets/lib/src/img/support/Adviser3.webp": "392534513d4fffd7041420b48574b713",
"assets/lib/src/img/support/support_chat.webp": "a8f6814236ae3b2d790a14bad850631b",
"assets/lib/src/img/support/Wompi.webp": "5b200626b32e6c7ce6e1a4f372b08601",
"assets/lib/src/img/support/Adviser4.webp": "55517c1cf9d1eb19a545ab0901eb1e8f",
"assets/lib/src/img/support/American_express.webp": "b38afe3aba102723513871c2513dc0c9",
"assets/lib/src/img/support/Visa.webp": "75ec377d708aeca0b40237fb645bc38d",
"assets/lib/src/img/WImagotipo.webp": "42bfb0ef0a308565a651b6ad31bbeb28",
"assets/lib/src/img/BIsotipo.webp": "fe7b4abf118398566d3b01b5293fb0b6",
"assets/lib/src/img/BImagotipo.webp": "a6c2f39a37e1c3a1f4f7310ec086e8f1",
"assets/lib/src/img/smartbag/standpack.webp": "913d523ca0fa6ceb5b81e9483edfc46f",
"assets/lib/src/img/smartbag/fall3.webp": "5f2ab6fcef74baaaf677599f0bf4bc8d",
"assets/lib/src/img/smartbag/flowpack.webp": "3590e3f41233dfb9f5fa7b4b0dea3e8c",
"assets/lib/src/img/smartbag/discover3.webp": "5754ca5899f629b3b71cf20d242deebb",
"assets/lib/src/img/smartbag/discover2.webp": "9e8f687bf74011c2fe8f60aca6c90171",
"assets/lib/src/img/smartbag/cojin.webp": "e44e9e66a84263fd6d220a192a89e374",
"assets/lib/src/img/smartbag/fall2.webp": "f6c6c1bcc774e77dabf00d9011705e50",
"assets/lib/src/img/smartbag/ventana.webp": "f7cf375c46b6b2bf2eea35b6716bfde7",
"assets/lib/src/img/smartbag/doypack.webp": "6cee83626584d9ce25246a3508a1bee1",
"assets/lib/src/img/smartbag/discover5.webp": "cebd2776af566ae876777086e0aa67a7",
"assets/lib/src/img/smartbag/discover9.webp": "be46615f7c4d74817c46aa47b265149c",
"assets/lib/src/img/smartbag/5pro.webp": "4436197a49cb548d60f260e84119c065",
"assets/lib/src/img/smartbag/valvula.webp": "f5fd27c33501fd5853540d02bd623107",
"assets/lib/src/img/smartbag/discover8.webp": "5bec3f14e5e52e49ce1918a27e623200",
"assets/lib/src/img/smartbag/4pro.webp": "ea8695eb0fc6286ac1818a02cb220006",
"assets/lib/src/img/smartbag/discover4.webp": "b9207198e87e12739d4670b08b68adda",
"assets/lib/src/img/smartbag/fall4.webp": "8a27bfaaacb9fefcce253d7d7afb8f64",
"assets/lib/src/img/smartbag/discover7.webp": "06618b36c5d81ddb1b943db685d3eaeb",
"assets/lib/src/img/smartbag/discover10.webp": "f5de98517b5544d06730e15c2a8a713a",
"assets/lib/src/img/smartbag/discover6.webp": "a3724279c3d2ee4c833dfe28668b9e2e",
"assets/lib/src/img/smartbag/piramide.webp": "9f6588a8cd4b75655d4ce93a3fd6b4b6",
"assets/lib/src/img/smartbag/discover1.webp": "4a5759c3ab57be09bf35613da0e1d794",
"assets/lib/src/img/smartbag/fall1.webp": "994efd55cb4feaa8cc75d124d6fa8854",
"assets/lib/src/img/WIsotipo.webp": "3db7ca17f49ef563f6ac09dacbd6672f",
"assets/lib/src/videos/catalog/backgroundus.mp4": "448b69cda914905ee7d8258d5c119460",
"assets/lib/src/fonts/D-DINExp-Bold.ttf": "fa367cc45817f512ff9da4d3b817561c",
"assets/lib/src/fonts/D-DINExp.ttf": "41ffa9abf903d51fdaabc3e27cb87273",
"assets/AssetManifest.bin": "8e7336b6c5f7d835359c9088a088c7d4",
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
