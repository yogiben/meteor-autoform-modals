# Template.CollectionModalButton.events
# 	'click .collection-modals': (e,t) ->
# 		$('#collection-modal').modal('show')
# 		collection = $(e.currentTarget).attr('collection')
# 		operation = $(e.currentTarget).attr('operation')
# 		_id = $(e.currentTarget).attr('doc')
# 		omitFields = $(e.currentTarget).attr('omitFields')
# 		doc = window[collection].findOne _id:_id
# 		html = $(e.currentTarget).html()

# 		Session.set('cmCollection',collection)
# 		Session.set('cmOperation',operation)
# 		Session.set('cmDoc',doc)
# 		Session.set('cmButtonHtml',html)
# 		Session.set('cmOmitFields',omitFields)

registeredAutoFormHooks = ['cmForm']

AutoForm.addHooks 'cmForm',
	onSuccess: ->
		$('#afModal').modal('hide')

collectionObj = (name) ->
	name.split('.').reduce (o, x) ->
		o[x]
	, window

Template.autoformModals.rendered = ->
	$('#afModal').on 'hidden.bs.modal', ->
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
			'cmPlaceholder'
		]
		delete Session.keys[key] for key in sessionKeys

Template.autoformModals.events
	'click button:not(.close)': () ->
		collection = Session.get 'cmCollection'
		operation = Session.get 'cmOperation'
		
		if operation != 'insert'
			_id = Session.get('cmDoc')._id
			
		if operation == 'remove'
			collectionObj(collection).remove _id, (e)->
				if e
					alert 'Sorry, this could not be deleted.'
				else
					$('#afModal').modal('hide')

helpers =
	cmCollection: () ->
		Session.get 'cmCollection'
	cmOperation: () ->
		Session.get 'cmOperation'
	cmDoc: () ->
		Session.get 'cmDoc'
	cmButtonHtml: () ->
		Session.get 'cmButtonHtml'
	cmFields: () ->
		Session.get 'cmFields'
	cmOmitFields: () ->
		Session.get 'cmOmitFields'
	cmButtonContent: () ->
		Session.get 'cmButtonContent'
	cmTitle: () ->
		Session.get 'cmTitle'
	cmButtonClasses: () ->
		Session.get 'cmButtonClasses'
	cmPrompt: () ->
		Session.get 'cmPrompt'
	cmTemplate: () ->
		Session.get 'cmTemplate'
	cmLabelClass: () ->
		Session.get 'cmLabelClass'
	cmInputColClass: () ->
		Session.get 'cmInputColClass'
	cmPlaceholder: () ->
		Session.get 'cmPlaceholder'
	cmFormId: () ->
		Session.get('cmFormId') or 'cmForm'
	title: () ->
		StringTemplate.compile '{{{cmTitle}}}', helpers
	prompt: () ->
		StringTemplate.compile '{{{cmPrompt}}}', helpers
	buttonContent: () ->
		StringTemplate.compile '{{{cmButtonContent}}}', helpers

Template.autoformModals.helpers helpers

Template.autoformModals.destroyed = -> $('body').unbind 'click'

Template.afModal.events
	'click *': (e, t) ->
		e.preventDefault()

		html = t.$('*').html()

		Session.set 'cmCollection', t.data.collection
		Session.set 'cmOperation', t.data.operation
		Session.set 'cmFields', t.data.fields
		Session.set 'cmOmitFields', t.data.omitFields
		Session.set 'cmButtonHtml', html
		Session.set 'cmTitle', t.data.title or html
		Session.set 'cmTemplate', t.data.template
		Session.set 'cmLabelClass', t.data.labelClass
		Session.set 'cmInputColClass', t.data.inputColClass
		Session.set 'cmPlaceholder', if t.data.placeholder is true then 'schemaLabel' else ''
		Session.set 'cmFormId', t.data.formId

		if not _.contains registeredAutoFormHooks, t.data.formId
			AutoForm.addHooks t.data.formId,
				onSuccess: ->
					$('#afModal').modal 'hide'
			registeredAutoFormHooks.push t.data.formId

		if t.data.doc
			Session.set 'cmDoc', collectionObj(t.data.collection).findOne _id: t.data.doc

		if t.data.buttonContent
			Session.set 'cmButtonContent', t.data.buttonContent
		else if t.data.operation == 'insert'
			Session.set 'cmButtonContent', 'Create'
		else if t.data.operation == 'update'
			Session.set 'cmButtonContent', 'Update'
		else if t.data.operation == 'remove'
			Session.set 'cmButtonContent', 'Delete'

		if t.data.buttonClasses
			Session.set 'cmButtonClasses', t.data.buttonClasses
		else if t.data.operation == 'remove'
			Session.set 'cmButtonClasses', 'btn btn-danger'
		else
			Session.set 'cmButtonClasses', 'btn btn-primary'

		if t.data.prompt
			Session.set 'cmPrompt', t.data.prompt
		else if t.data.operation == 'remove'
			Session.set 'cmPrompt', 'Are you sure?'
		else
			Session.set 'cmPrompt', ''