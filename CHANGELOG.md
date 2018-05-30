## 0.19.0

* Include `online_booking_weekends` in the response

## 0.18.0

* Include the locations index API call and response

## 0.17.0

* Update stubbed JSON with canonical twilio number changes

## 0.16.0

* Remove deprecated slots since they're now controller by planner

## 0.15.0

* Loosen Active Support dependency

## 0.14.0

* Include `online_booking_reply_to` in API response

## 0.13.0

* Don't mutate cache prefixes in place

## 0.12.0

* Add ability to clear all prefixed cache entries

## 0.11.0

* Add cache key namespacing / prefixing

## 0.10.0

* Add `Location#hidden` flag and predicate

## 0.9.1

* Respect TTL options

## 0.9.0

* Restructured slot nesting for locations
* Ensure child locations are stubbed properly

## 0.8.0

* Guard against missing or outdated location names

## 0.7.0

* Add stubbed responses for Taunton and children

## 0.6.1

* Replace our own null cache with Rails' `NullStore`

## 0.6.0

* Adds configurable caching for location responses

## 0.5.0

* Return guider's name by ID
* Return location instance by ID

## 0.4.0

* Support GlobalID identification

## 0.3.0

* Include `Accept` header in requests to JSON API

## 0.2.1

* Return `online_booking_twilio_number` in stubbed response

## 0.2.0

* Expose `online_booking_twilio_number`

## 0.1.0

* Initial release
