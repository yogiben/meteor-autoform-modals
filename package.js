Package.describe({
  name: 'collection-modals',
  summary: 'Adds modals to insert/update/remove documents from a collection'
});

Package.on_use(function (api) {

 api.use(['jquery','templating','less','session','coffeescript','ui','autoform','handlebar-helpers'], 'client');
 
 api.add_files('lib/client/modals.html', 'client');
 api.add_files('lib/client/modals.coffee', 'client');
 api.add_files('lib/client/modals.less', 'client');

});