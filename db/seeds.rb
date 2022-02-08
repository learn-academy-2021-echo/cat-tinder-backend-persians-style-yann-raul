cats = [
    {
      name: 'Felix',
      age: 2,
      enjoys: 'Long naps on the couch, and a warm fire.',
      image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    },
    {
      name: 'Homer',
      age: 12,
      enjoys: 'Food mostly, really just food.',
      image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
    },
    {
      name: 'Lola',
      age: 12,
      enjoys: 'loves her food more than me.',
      image: 'https://static.onecms.io/wp-content/uploads/sites/34/2021/09/27/black-cat-kitchen-rug-getty-0921-2000.jpg'
    },
    {
      name: 'Garfield',
      age: 8,
      enjoys: 'give me some more lasagna.',
      image: 'https://www.pluggedin.com/wp-content/uploads/2019/12/garfield-the-movie-1200x720.jpg'
    },
    {
      name: 'Artemus',
      age: 7,
      enjoys: 'I can see dead people.',
      image: 'https://i.ytimg.com/vi/iKA6ZXpGcGQ/maxresdefault.jpg'
    }
  ]
  
  cats.each do |each_cat|
    Cat.create each_cat
    puts "creating cat #{each_cat}"
  end