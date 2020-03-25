require('pry')
require_relative('../models/album')
require_relative('../models/artist')


artist1 = Artist.new({'name' => 'Daft Punk'})
artist2 = Artist.new({'name' => 'Daft Punk'})

artist1.save()
artist2.save()


binding.pry
nil
