Package.describe({
<<<<<<< HEAD
  summary: "Create, update and delete collections with modals",
  version: "0.1.1",
  git: "https://github.com/yogiben/meteor-autoform-modals"
=======
  name: 'collection-modals',
  summary: 'Adds modals to insert/update/remove documents from a collection'
>>>>>>> 788ef62483dcd236b4700371bdf2627b3e0bd076
});

Package.on_use(function (api) {

<<<<<<< HEAD
api.versionsFrom('METEOR@0.9.0');

 api.use(['jquery','templating','less','session','coffeescript','ui','aldeed:autoform@2.0.2','raix:handlebar-helpers@0.1.2'], 'client');
=======
 api.use(['jquery','templating','less','session','coffeescript','ui','autoform','handlebar-helpers'], 'client');
>>>>>>> 788ef62483dcd236b4700371bdf2627b3e0bd076
 
 api.add_files('lib/client/modals.html', 'client');
 api.add_files('lib/client/modals.coffee', 'client');
 api.add_files('lib/client/modals.less', 'client');

<<<<<<< HEAD
});
=======
});
>>>>>>> 788ef62483dcd236b4700371bdf2627b3e0bd076
