# Travel-Time-to-Work-Dashboard
## Purpose
Two things led to the idea for this project: jury duty and the amount of time it took to get there! Los Angeles has two periods in which traffic is excruciating, day and night. "Gee... It's bad enough that jury duty starts at 9. Everyone on their way to work, stuck in traffic, have it better." I thought. It got me thinking that if I were to escape egregious LA traffic, I would need to find a new home where traveling to work isn't so bad. With an empty LinkedIn project section depriving me of professional vibrancy, I came across a dataset I would like to use for a potential portfolio project. I want to determine the best place to live so that I don't have to spend half of the day traveling to work! I developed a Tableau dashboard to answer my questions and help others find areas that meet their traveling preferences.
## About the Travel Time to Work and Means of Transportation to Work datasets
The datasets are CSV files with headers for the columns as:

1. geoid - holds the geospatial unique identifier of the census tract. This can be used by tableau in conjuction with the census tract shapefile to provide maps with census tract detailing
2. statefp - holds the Federal Information Processing Standards (FIPS) code assigned to each State
3. countyfp - similar to statefp, this column holds the FIPS code assigned to the county
4. tractce - stands for census Tract Code Extension which helps identify the census tract within it's relative county
5. tractid - yhe Tract Id is pretty much the same as the tractce except that it is tractce divided by a thousand and is a float
6. namelsad - dtands for the name of the Legal and Statistical Area Description. This is just "Census Tract" + "tractid"
7. name - contains the namelsad, name of county and state in a single string
8. hh_tot - holds the total amount of workers that have a contribution in any of the following columns
9. hh_0009 - has the amount of workers who's travel time to work is between 0 - 9 mins
10. hh_1019 - has the amount of workers who's travel time to work is between 10 - 19 mins
11. hh_2029 - has the amount of workers who's travel time to work is between 20 - 29 mins
12. hh_3044 - has the amount of workers who's travel time to work is between 30 - 44 mins
13. hh_4559 - has the amount of workers who's travel time to work is between 40 - 59 mins
14. hh_6089 - has the amount of workers who's travel time to work is between 60 - 89 mins
15. hh_90up - has the amount of workers who's travel time to work is between 90 & up mins
16. hh_0009_p - has the percentage of workers (out of total workers) who's travel time is between 0 - 9 mins
17. hh_1019_p - has the percentage of workers (out of total workers) who's travel time is between 10 - 19 mins
18. hh_2029_p - has the percentage of workers (out of total workers) who's travel time is between 20 - 29 mins
19. hh_3044_p - has the percentage of workers (out of total workers) who's travel time is between 30 - 44 mins
20. hh_4559_p - has the percentage of workers (out of total workers) who's travel time is between 45 - 59 mins
21. hh_6089_p - has the percentage of workers (out of total workers) who's travel time is between 60 - 89 mins
22. hh_90up_p - has the percentage of workers (out of total workers) who's travel time is between 90 & up mins
23. shape_Length - has the length (or perimeter) of the census tract
24. shape_Area - has the area of the census tract

## Navigating the *Repository*
Here are the links to the datasets I used for this project: [Travel Time to Work Dataset](https://geodata.bts.gov/datasets/usdot::travel-time-to-work/about) and [Means of Transportation to Work](https://geodata.bts.gov/datasets/usdot::means-of-transportation-to-work/about).

If you are interested, check out the MySQL code that lead to the results used in the tableau dashboard [HERE](Travel_Time_to_Work_Code.sql) .

And if you happened to stumble on my project (not through LinkedIn at least) here is my [dashboard](https://public.tableau.com/views/TravelTimeTransportDashboard/FinalBoard?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)!
