

=== Setup ===

`config/application.yml` should have the posgres password.

The following setup will execute the seeds, it tries to add too many records to database, it will take some time to seed, while it is adding those records, you may start the app from other console

````
$bundle exec rake db:setup

````
=== How To ===

from admin, products, edit any product, and modify categories

=== TBD ===

 - ability to view/alter categories in tree form
 - best visual to edit product-categories mapping
 - admin side stats like consumer view counts, edit counts, frequent searches
 - testing including jasmine, coverage, unit, integration, views, controller, peak load, concurrency, security, global ping
 - API designing like http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api
 - search filter based on selected/checkboxed categories
 - solr based mapping of product to similar products, or other products people have purchased or what your friends purchased etc
 - CDN support for assets, landing, show pages
 - social connect etc integration
 - 3rd party integration like payments, verification and more
 - performance check on JS, and each every case included in search result
 - browser pagination for search results using push back state
 - find out more and more corner cases where end users inputs are accepted and fix them
 - once settled, define micro-services using faster languages like Go, Scala and provide various services like search, caching, purging, counting, analytics, tracking and more
 - and some mentioned in products controller
 - I am not at all happy with this hello world approach here, we need really better indexing of data
 - all product data must be text-indexed including their categories
 - all categories must be indexed
 - no need to keep relation between product and category records but indexes only
 - relations are good when dealing with individual records for auditing/tracking purpose
 - for searching, it is only text indexes and id mapping indexes








