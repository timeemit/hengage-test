HEngage-Test
============

This is a basic time tracking app, like you might have at an agency that does work for a number of clients, and needs to track the number of hours to bill to each client.

There are two different classes of user: admins and regular users.

Both classes of user can log in, using their email as a username, and must log in to use the site. But authentication can be hardcoded: that is, assume every user has the password "foobar" and authenticate against that. On logging in, the user should stay logged in until they explicitly log out.

Admins can set up and modify projects. They can add and edit regular users. They also have a few reports available to them (more about reports below). You'll want a small script to seed the database with at least one admin.

Either class of user can allocate blocks of their time to different projects: for example, "I worked on the XYZCorp website redesign from 12:20 PM 3/1/2013 to 4:15 PM 3/1/2013." They can edit or delete these blocks of time afterwards. These blocks of time should never be allowed to overlap. The exact interface for working with these blocks is up to you.

There are two types of reports that admins (but not regular users) should be able to view:
  - Given a certain project, and a date/time interval, how many hours total did all users log to that project during that time interval?
  - Given a certain user, and a date/time interval, to which projects did that user log time in that interval, and how many hours per project?

In both these reports, the reported time should be rounded to the nearest quarter hour.



Some general things to keep in mind:

What I'm interested in seeing here are the software design choices you make and the rationale behind them, so feel free to use both comments in the code and git commit messages to explain your thinking.

This is a lot to bite off in a few evenings. Hence, a simple and straightforward (and ugly) interface is acceptable. But if you do have the time, a pretty and/or more interactive frontend will be counted for extra credit.

Tests also count. You can use your choice of testing framework.

Any gems from rubygems.org are fair game to use.