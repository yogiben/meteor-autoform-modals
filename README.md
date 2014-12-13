Meteor [Autoform](https://github.com/aldeed/meteor-autoform) Modals
======================

Adds bootstrap modals to insert/update/remove docs from Meteor collections.

## Setup ##

1. ```meteor add yogiben:autoform-modals```
2. Include the template in the layouts that will use the modals `{{> autoformModals}}`
3. Use `afModal` template to create a button that will trigger the modal


![alt tag](https://raw.githubusercontent.com/yogiben/meteor-autoform-modals/master/readme/1.png)

##Example Button Markup##
### Insert Example ###
```
{{#afModal class="btn btn-primary" collection="Posts" operation="insert"}}
  Add a new post
{{/afModal}}
```
### Update Example ###
```
{{#afModal class="btn btn-primary" collection="Posts" operation="update" doc=_id}}
  Update post
{{/afModal}}
```
### Remove Example ###
```
{{#afModal class="btn btn-danger" collection="Posts" operation="remove" doc="mpb8f7m6x929DwTau"}}
  Delete post
{{/afModal}}
```
or
```
{{#afModal class="btn btn-danger" collection="Posts" operation="remove" doc=_id}}
  Delete post
{{/afModal}}
```
### Example with customisation ###
```
{{#afModal class="btn btn-primary" collection="Posts" omitFields="createdAt,owner,upvotes" operation="update" buttonContent="Update Challenger" prompt="Use this form to update your doc" title="Update your great content" buttonClasses="btn-success"}}
  Update your post
{{/afModal}}
```
##Usage##
Use `afModal` template to create a link that will trigger the modal.
The required attributes of this template are ``collection`` & ``operation``.

Collection should be the name of the global collection object e.g. Posts.

Operation can be ```insert```,```update``` or ```remove```.

If ```operation="update``` or ```operation="remove"``` you also need to set the ```doc``` property to the _id of the document.

## Customisation ##
It is possible to customise the modals by adding additional attributes to the `afModal` template.
* ```title``` will be the title of the modal (default to html of the button clicked)
* ```buttonContent``` is the html content of the modals' button (default to html of the button clicked)
* ```fields``` is a comma separated list of the only fields that should be in the form. See the [autoform docs](https://github.com/aldeed/meteor-autoform).
* ```omitFields``` is a comma separated list of fields to omit. See the [autoform docs](https://github.com/aldeed/meteor-autoform).
* ```buttonClasses``` allows you to add different classes to the submit button. See the [autoform docs](https://github.com/aldeed/meteor-autoform).
* ```prompt``` a paragraph appears above the form / delete button. Defaults to 'Are you sure?' on delete.
