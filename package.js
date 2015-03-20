Package.describe({
  name: 'gabrielpoca:autoform-modals',
  summary: 'Create, update and delete collections with modals',
  version: '0.3.2',
  git: 'https://github.com/gabrielpoca/meteor-autoform-modals'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@1.0');

  api.use([
    'jquery',
    'templating',
    'less',
    'session',
    'coffeescript',
    'ui',
    'aldeed:autoform@4.2.2',
    'raix:handlebar-helpers@0.2.4',
    'mpowaga:string-template@0.1.0'
  ], 'client');

  api.add_files('lib/client/modals.html', 'client');
  api.add_files('lib/client/modals.coffee', 'client');
  api.add_files('lib/client/modals.less', 'client');
});
