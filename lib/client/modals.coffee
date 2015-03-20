registeredAutoFormHooks = ['cmForm']

sessionKeys = [
  'cmCollection',
  'cmOperation',
  'cmDoc',
  'cmButtonHtml',
  'cmFields',
  'cmOmitFields',
  'cmButtonContent',
  'cmTitle',
  'cmButtonClasses',
  'cmPrompt',
  'cmTemplate',
  'cmLabelClass',
  'cmInputColClass',
  'cmPlaceholder',
  'cmSchema'
]


AutoForm.addHooks 'cmForm',
  onSuccess: ->
    $('#afModal').modal('hide')

getCollectionFromString = (name) ->
  name.split('.').reduce (o, x) ->
    o[x]
  , window

capitalizeFirstLetter = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

Template.autoformModals.rendered = ->
  $('#afModal').on 'hidden.bs.modal', ->
    delete Session.keys[key] for key in sessionKeys

Template.autoformModals.events
  'click button:not(.close)': () ->
    collection = Session.get 'cmCollection'
    operation = Session.get 'cmOperation'
    
    if operation != 'insert'
      _id = Session.get('cmDoc')._id
      
    if operation == 'remove'
      getCollectionFromString(collection).remove _id, (e)->
        if e
          alert 'Sorry, this could not be deleted.'
        else
          $('#afModal').modal('hide')

helpers =
  attributes: () ->
    keys = [
     'schema',
     'title',
     'collection',
     'doc',
     'buttonContent',
     'fields',
     'omitFields',
     'template',
     'buttonHtml',
     'buttonClasses',
    ]

    attrs = _.reduce keys, (memo, item) ->
        sessionKey = "cm#{capitalizeFirstLetter(item)}"
        memo[item] = Session.get(sessionKey)
        return memo
      , {}

    attrs['id'] = Session.get('cmFormId') or 'cmForm'
    attrs['type'] = Session.get('cmOperation')
    attrs['label-class'] = Session.get('cmLabelClass')
    attrs['input-col-class'] = Session.get('cmInputColClass')
    attrs['afFieldInput-placeholder'] = Session.get('cmPlaceholder')
    console.log attrs
    attrs

  cmCollection: () ->
    Session.get('cmCollection')
  cmOperation: () ->
    Session.get('cmOperation')
  cmPrompt: () ->
    Session.get 'cmPrompt'
  cmTitle: () ->
    Session.get('cmTitle')
  title: () ->
    StringTemplate.compile '{{{cmTitle}}}', helpers
  prompt: () ->
    StringTemplate.compile '{{{cmPrompt}}}', helpers
  cmButtonClasses: () ->
    Session.get('cmButtonClasses')
  cmButtonContent: () ->
    Session.get('cmButtonContent')
  buttonContent: () ->
    StringTemplate.compile '{{{cmButtonContent}}}', helpers

Template.autoformModals.helpers helpers

Template.autoformModals.destroyed = -> $('body').unbind 'click'

Template.afModal.events
  'click *': (e, t) ->
    e.preventDefault()

    html = t.$('*').html()

    keys = [
      'collection',
      'operation',
      'fields',
      'omitFields',
      'template',
      'labelClass',
      'inputColClass',
      'formId',
      'schema'
    ]

    for key in keys
      sessionKey = "cm#{capitalizeFirstLetter(key)}"
      Session.set(sessionKey, t.data[key])

    Session.set('cmOmitFields', t.data.omitFields)
    Session.set('cmButtonHtml', html)
    Session.set('cmTitle', t.data.title or html)

    if t.data.placeholder
      Session.set('cmPlaceholder', 'schemaLabel')
    else
      Session.set('cmPlaceholder', '')

    if not _.contains(registeredAutoFormHooks, t.data.formId)
      AutoForm.addHooks t.data.formId,
        onSuccess: ->
          $('#afModal').modal 'hide'
      registeredAutoFormHooks.push(t.data.formId)

    if t.data.doc
      doc = getCollectionFromString(t.data.collection).findOne(_id: t.data.doc)
      Session.set 'cmDoc', doc

    console.log t.data
    if t.data.buttonContent
      Session.set('cmButtonContent', t.data.buttonContent)
    else if t.data.operation == 'insert'
      Session.set('cmButtonContent', 'Create')
    else if t.data.operation == 'update'
      Session.set('cmButtonContent', 'Update')
    else if t.data.operation == 'remove'
      Session.set('cmButtonContent', 'Delete')

    if t.data.buttonClasses
      Session.set('cmButtonClasses', t.data.buttonClasses)
    else if t.data.operation == 'remove'
      Session.set('cmButtonClasses', 'btn btn-danger')
    else
      Session.set('cmButtonClasses', 'btn btn-primary')

    if t.data.prompt
      Session.set('cmPrompt', t.data.prompt)
    else if t.data.operation == 'remove'
      Session.set('cmPrompt', 'Are you sure?')
    else
      Session.set('cmPrompt', '')
