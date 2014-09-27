meteor-autoform-modals
======================
```meteor add yogiben:autoform-modals```

Adds modals to insert/update/delete Meteor collections.

1. Include the template in the layouts you need the modals `{{> collectionModals}}`
2. Add a button to trigger the modal

##Examples##
### Insert Example ###
```
<a href="#afModal" class="btn btn-primary" collection="Posts" operation="insert" doc="mpb8f7m6x929DwTau">Add a new post</a>
```
### Update Example ###
```
<a href="#afModal" class="btn btn-primary" collection="Posts" operation="update" doc="mpb8f7m6x929DwTau">Update post</a>
```
### Remove Example ###
```
<a href="#afModal" class="btn btn-danger" collection="Posts" operation="remove" doc="mpb8f7m6x929DwTau">Delete post</a>
```
### Example with customisation ###
```
<a href="#afModal" class="btn btn-primary" collection="Posts" omitFields="createdAt,owner,upvotes" operation="insert" buttonContent="New Challenger" title="Add a new public post" buttonClass="btn-success">Create a new challenger</a>
```
##Usage##
Elements with ```href="#afModal"``` will trigger the modal.
The required attributes on this element are ``collection`` & ``operation``.

Collection should be the name of the global collection object e.g. Posts.

Operation can be ```insert```,```update``` or ```remove```.

If ```operation="update``` or ```operation="remove"``` you also need to set the ```doc``` property to the _id of the document.

## Customisation ##
It is possible to customise the modals by adding additional attributes to the ```href="#afModal"``` element that triggers the modal.
* ```title``` will be the title of the modal (default to html of the button clicked)
* ```buttonContent``` is the html content of the modals' button (default to html of the button clicked)
* ```omitFields``` is a comma separated list of fields to omit. See the [autoform docs](https://github.com/aldeed/meteor-autoform).
* ```buttonClasses``` allows you to add different classes to the submit button. See the [autoform docs](https://github.com/aldeed/meteor-autoform).
