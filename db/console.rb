require('pry')
require_relative('../models/album')
require_relative('../models/artist')


artist1 = Artist.new({'name' => 'Daft Punk'})
artist1.save()
artist2 = Artist.new({'name' => 'Ariana Grande'})
artist2.save()

album1 = Album.new({'title' => "Discovery",
                      'genre' => "EDM",
                      'artist_id' => artist1.id})
album1.save()

album2 = Album.new({'title' => "Random Access Memory",
                        'genre' => "EDM",
                        'artist_id' => artist1.id})
album2.save()


binding.pry
nil
