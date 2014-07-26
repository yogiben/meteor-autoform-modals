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

Template.CollectionModals.helpers
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

Template.CollectionModals.rendered = () ->
	$('body').on "click", (e)->
		if $(e.target).attr('href') == '#collectionModal'
			$('#collectionModal').modal('show')
			collection = $(e.target).attr('collection')
			operation = $(e.target).attr('operation')
			_id = $(e.target).attr('doc')
			omitFields = $(e.target).attr('omitFields')
			html = $(e.target).html()
			title = html
			buttonContent = html

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

Template.CollectionModals.destroyed = -> $('body').unbind 'click'

AutoForm.hooks(
	cmForm : 
		onSuccess: (operation, result, template)->
			$('#collectionModal').modal('hide')
		)