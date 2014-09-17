A coding practice challenge from Groupize.
==========================================

Criteria
--------

Please create a web application that shows a sortable table of role
information for Shakespeare's plays. The table should show the following
statistics for each role in the play: number of lines spoken, longest
speech, number of scenes in which the role appears, and percent of total
scenes in which the role appears.

Clicking on a column header should sort the data by the selected column,
without reloading the page. Clicking on a column header again should
flip the direction of the sort.

Only 10 roles should be shown at a time (the top or bottom 10, depending
on the sort).

The XML file in this gist contains Shakespeare's play
"Julius Caesar" in XML format.

Assume you will eventually have access to
similar files for Shakespeare's other plays. It is not necessary to
display statistics from any other play for this proof of concept.

You are not expected to complete a polished visual design for this
application. It should be styled enough that function of the application
is clear.

Please use Github to host the source code for your application, and host
the application for free on Heroku.

You may find the following information about the XML layout helpful:
- PGROUPs have no relevance to this problem.
- PERSONA is the XML element indicating a role. Not all PERSONA elements speak.
- You may ignore any lines given by "All".


Setup
-----

- Clone the repo
- `bundle`
- `rake db:create`
- `rake db:migrate`
- `rake db:seed`
- `rails server`
