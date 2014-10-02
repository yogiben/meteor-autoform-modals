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

Template.autoformModals.helpers
	cmCollection: () ->
		Session.get 'cmCollection'
	cmOperation: () ->
		Session.get 'cmOperation'
	cmDoc: () ->
		Session.get 'cmDoc'
	cmButtonHtml: () ->
		Session.get 'cmButtonHtml'
	cmOmitFields: () ->
		Session.get 'cmOmitFields'
	cmButtonContent: () ->
		Session.get 'cmButtonContent'
	cmTitle: () ->
		Session.get 'cmTitle'
	cmButtonClasses: () ->
		Session.get 'cmButtonClasses'

Template.autoformModals.destroyed = -> $('body').unbind 'click'

Template.autoformModals.rendered = () ->
	$('body').on "click", (e)->
		if $(e.target).attr('href') == '#afModal'
			collection = $(e.target).attr('collection')
			operation = $(e.target).attr('operation')
			_id = $(e.target).attr('doc')
			omitFields = $(e.target).attr('omitFields')
			buttonClasses = $(e.target).attr('buttonClasses')
			html = $(e.target).html()
			title = html
			buttonContent = html

			console.log(buttonClasses)

			if $(e.target).attr('title')
				title = $(e.target).attr('title')

			if $(e.target).attr('buttonContent')
				buttonContent = $(e.target).attr('buttonContent')

			if _id
				doc = window[collection].findOne _id:_id

			Session.set('cmCollection',collection)
			Session.set('cmOperation',operation)
			Session.set('cmDoc',doc)
			Session.set('cmButtonHtml',html)
			Session.set('cmOmitFields',omitFields)
			Session.set('cmTitle',title)
			Session.set('cmButtonContent',buttonContent)
			Session.set('cmButtonClasses',buttonClasses)

AutoForm.hooks(
	cmForm : 
		onSuccess: (operation, result, template)->
			$('#afModal').modal('hide')
		)