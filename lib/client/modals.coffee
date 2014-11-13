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

Template.autoformModals.events
	'click button:not(.close)': () ->
		collection = Session.get 'cmCollection'
		operation = Session.get 'cmOperation'
		
		if operation !== 'insert'
			_id = Session.get('cmDoc')._id
			
		if operation == 'remove'
			window[collection].remove _id, (e)->
				if e
					alert 'Sorry, this could not be deleted.'
				else
					$('#afModal').modal('hide')

Template.autoformModals.helpers
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

Template.autoformModals.destroyed = -> $('body').unbind 'click'

Template.autoformModals.rendered = () ->
	$('body').on "click", (e)->
		if $(e.target).attr('href') == '#afModal'
			collection = $(e.target).attr('collection')
			operation = $(e.target).attr('operation')
			_id = $(e.target).attr('doc')
			html = $(e.target).html()

			if $(e.target).attr('fields')
				fields = $(e.target).attr('fields')
			else
				omitFields = null

			if $(e.target).attr('omitFields')
				omitFields = $(e.target).attr('omitFields')
			else
				omitFields = null


			if $(e.target).attr('buttonClasses')
				buttonClasses = $(e.target).attr('buttonClasses')
			else if operation == 'remove'
				buttonClasses = 'btn btn-danger'
			else
				buttonClasses = 'btn btn-primary'


			if $(e.target).attr('title')
				title = $(e.target).attr('title')
			else
				title = html

			if $(e.target).attr('buttonContent')
				buttonContent = $(e.target).attr('buttonContent')
			else if operation == 'insert'
				buttonContent = 'Create'
			else if operation == 'update'
				buttonContent = 'Update'
			else if operation == 'remove'
				buttonContent = 'Delete'

			if $(e.target).attr('prompt')
				prompt = $(e.target).attr('prompt')
			else if operation == 'remove'
				prompt = 'Are you sure?'
			else
				prompt = ''

			if _id
				doc = window[collection].findOne _id:_id

			Session.set('cmCollection',collection)
			Session.set('cmOperation',operation)
			Session.set('cmDoc',doc)
			Session.set('cmButtonHtml',html)
			Session.set('cmFields',fields)
			Session.set('cmOmitFields',omitFields)
			Session.set('cmTitle',title)
			Session.set('cmButtonContent',buttonContent)
			Session.set('cmButtonClasses',buttonClasses)
			Session.set('cmPrompt',prompt)

AutoForm.hooks(
	cmForm : 
		onSuccess: (operation, result, template)->
			$('#afModal').modal('hide')
		)
