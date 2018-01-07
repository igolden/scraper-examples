Scraper Examples
===

This project is just a small sample of building and integrating scrapers into rails. There are numerous ways to implement this functionality in every language, and in this case I'll be using Capybara due to project constraints.

### Goals

* Scrape a remote website for events, load them into a calendar.
* Implement an in browser solution via capybara/js
* Implement a microservice approach that could be ran as a background job
* Test Coverage

---

###  Constraints

* This project is a code example, so UI does not matter
* This project should take no longer that 3 hours start to finish
* Use capybara on at least one example
* Integrate into a traditional (not api-first) rails 5 app

---

### In Browser Request

The first approach is an on demand call to an external webpage via scraper. When the user hit the page we display a loader, then scrape and return the data from the remote page.

This approach gives the "real-time" data from the remote page, but has some performance bottlenecks:

  * Request could fail, and user doesn't get results
  * Requests the remote page too frequently, if there are many users
  * Slower response time, because it would be faster to load and cache from our own app


---

### Microservice Request

The second approach is to offload the downloading of remote data into a microservice, and parse and save that data. You can run this job occasionally to reduce load on external resources and keep your data up to date enough for non-critical information.

Pros/Con: 
  
  * Less footprint, which is important for scrapers
  * Will not have "real-time" data
