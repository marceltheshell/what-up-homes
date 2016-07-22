# Geocoder = require('geocoder')

Geocoder.configure(
  
  :use_https => true,

  :api_key => "AIzaSyCjtbHo4LVNWosP75hQD37CdyO6aGBzmwU",
  # geocoding service
  lookup: :google,

  # geocoding service request timeout (in seconds)
  timeout: 10,

  # default units
  units: :km
)