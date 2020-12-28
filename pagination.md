*[previous page: gcd](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/gcd.md)*

# Pagination

What is pagination and how do you use it?

Before jumping in, an example of pagination is in the feedview of the YouTube app, as you scroll down, you have more video recommendations appear on the screen. And this is done through pagination. There's different ways to achieve pagination, but it ultimately gives you a infinite scroll kind of feel. 

A way to achieve this is as you scroll down the screen, let's say it's a tableview, there's delegate method calls, which you have to set on your tableview first — `UITableView.prefetchDataSource`, such as the `tableviewPrefetchRowsAt` and that's when you'd calculate wether or not to call another endpoint to increment more information onto the list of results from previous calls. The ideal way to do it is to have data of the last elements ID, any unique value. and you'd use that to pass it through the query and get the following elements (info) from that ID.

You wouldn't want to preload thousands of data input becuase a couple of reasons

1. It will be very heavy on server to create and hand over the data.
2. Users might not even scroll and view all the input.
3. The app would have to process all of that data.

One thing to keep in mind of pagination is wether or not the data base is updating. If it is being updated, you'd want to account for if passing in an index and it containing duplicate values.

*[next page: access control](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/accessControl.md)*
