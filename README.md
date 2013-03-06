# Focal [![Build Status](https://travis-ci.org/kabisaict/focal.png?branch=master)](https://travis-ci.org/kabisaict/focal)

Focal is a tool to create sexy burndowns from one ore more Pivotal Tracker
projects.

_Note: at this time Focal is still in early development and probably not
usable for anything else than adding more features and fixing bugs._

See the github wiki for more details.

## Deployment

TODO: Write deployment info for Heroku.

## Development

Focal is tested against ruby 1.9.3 and ruby-2.0.0. Setting Focal up for local
development is pretty straight forward:

    bundle install
    rake db:migrate
    rake db:seed    # To generate a sample burndown

A rake task exists if you want to pull real data from Pivotal Tracker (note that
this does not work with the seed burndown):

    rake focal:import

## Authors

Focal is a Kabisa initiative.

 * Ariejan de Vroom <ariejan@ariejan.net>

## License

Focal is licensed under the MIT license. See `LICENSE.txt` for details.
