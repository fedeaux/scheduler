# README

## Running

Install ruby

Install bundler

Install docker and docker-compose

Clone this repo

In the folder

`bundle i`

`docker-compose up`

`rake db:create db:migrate`

`rails server`

In another terminal
`./bin/webpack-dev-server`

Open `localhost:3000`

### Running Tests
`rspec`

This project is deployed to [heroku](https://kolau-scheduler.herokuapp.com)

## Decisions

At first I added validations locally, for example, `view_models/scheduler/form/hour` was responsible for validating the input format and `view_models/scheduler/form/day` was responsible for validating the timespan. But since it is wise to validate everything before sending the request and I wanted to disable the "save" button if the data wasn't valid, I moved all the validations to `view_models/scheduler/form.vue`. Upside is everything is more organized, downside is that child components are not reusable. Other solutions could be using Vuex or doing more complex ups and downs of state.

I decided to keep using times as a string from end to end for the purposes of the exercise, a real application would probably use a library like `moment.js`.

## Further Developments

- We could do a "smart input" that auto changes the input value. Like '1200' -> '12:00', or transform the "interpreted" pm into actual pm '11:00' -> '23:00' or '11:pm'.
- The ui always interprets the finish time as PM if it is before 12:00, this prohibits the user from being available from 09:00am to 10:00am for example.
- The ui doesn't accept 24:00 as the regex would be more complicated, but it is doable.
- The ui accepts 00:00 as the finish time, it is weird but it interprets it as 12:00.
- The ui shows an error when the user inputs the start time and move to finish time 'Please select both times', we could use the concept of "touched" to only show this error if the user fills the start, goes to the finish, and leaves the finish without inputting in anything.
- Better navigation.
- The folder `view_models/scheduler` (and all of its components) only made sense before I decided to do the full crud, I'd rename it to schedules.
- We could separate some of the code in `app/javascript/packs/application` into their own modules.
- We could remove code duplication in `view_models` with vue mixins. For example: for routes and interactions with `resources/Schedule.coffee` resource.
- `resources/Schedule.coffee` is really basic and could be improved to have a superclass, and use less clones.
- We could encapsulate json data into proper objects, so, for example `Day` could have a calculated attribute `weekday_name`.
- We could use Vuex to handle schedule data.
- The backend creates a Schedule even with partially valid days. We could either spend more time finding the rails way of doing that or extract the create schedule business action into a separate class `BusinessActions::Schedule::Create` that validates everything.
- `models/day_spec` could be better written to use shared examples and spec more validations.
- I'm so used to ruby from the past months I forgot the convention for js is camelCase.
