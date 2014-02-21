## New Curriculum

This is a Rails app that will host our existing curriculum.

### Add New Tutorials

For new tutorials, create a new file following this format: `new_tutorial.html.markdown` under the `app/curriculum` folder. Once created, a route will be created based on the filename, such as http://tutorials.jumpstartlab.com/new_tutorial.

### Index the Pages

Once you have solr installed, you can start it with `rake sunspot:solr:start`. Make sure solr is running before indexing.

There is a rake task for indexing the tutorial pages:

* `rake pages:generate` for generate, index and store pages in the database.
* `rake index:drop` for deleting the pages in the database.
* `rake index:setup` for deleting the pages and regenerating them.

### ToDo

* Improve test coverage.