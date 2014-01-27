## New Curriculum

This is a Rails app that will host our existing curriculum.

### Add New Tutorials

For new tutorials, create a new file following this format: `new_tutorial.html.markdown` under the app/pages folder. Once created, a route will be created based on the filename, such as http://tutorials.jumpstartlab.com/new_tutorial.

### Index the Pages

There is a rake task for indexing the tutorial pages:

* `rake index:pages` for indexing pages.
* `rake index:drop` for deleting the index.
* `rake index:setup` for deleting the index and indexing the pages.

### ToDo

* Install Solr for searching the pages.
* Improve test coverage.
* Implement liquid tags for rendering terminal outputs.