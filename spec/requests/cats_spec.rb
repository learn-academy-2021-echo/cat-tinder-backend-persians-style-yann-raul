require 'rails_helper'

RSpec.describe "Cats", type: :request do

  describe "GET /index" do
    it 'gets a list of cats' do
      # create a cat
      Cat.create(
        name: 'Toast',
        age: 2,
        enjoys: 'having thumbs',
        image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
      )
      # make an index request
      get '/cats'

      # parse our request data
      cat = JSON.parse(response.body)

      # asserting against the response code
      expect(response).to have_http_status(200)
      # asserting against the payload
      expect(cat.length).to eq 1
    end
  end

  describe "POST /create" do
    it 'creates a cat' do
      # create a cat
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }

      # make a request
      post '/cats', params: cat_params

      # asserting against the response code
      expect(response).to have_http_status(200)

      # pull the cat from the db
      cat = Cat.first

      # asserting against the payload
      expect(cat.name).to eq('Toast')
      expect(cat.age).to eq(2)
      expect(cat.enjoys).to eq('having thumbs')
      expect(cat.image).to eq('https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg')
    end
    it 'doesnt create a cat without a name' do
      cat_params = {
        cat: {
          
          age: 2,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p json['name']
      expect(json['name']).to include "can't be blank"
    end
    it 'doesnt create a cat without an image' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'having thumbs'
        }
      }
      post '/cats', params: cat_params

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p json['image']
      expect(json['image']).to include "can't be blank"
    end
    it 'doesnt create a cat without a age' do
      cat_params = {
        cat: { 
          name: 'Toast',
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p json['age']
      expect(json['age']).to include "can't be blank"
    end
    it 'doesnt create a cat without an enjoys' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p json['enjoys']
      expect(json['enjoys']).to include "can't be blank"
    end
    it 'doesnt create a cat without enjoys being at least 10 characters' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: '1234',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p json['enjoys']
      expect(json['enjoys']).to include "is too short (minimum is 10 characters)"
    end
  end

  describe "PATCH /update" do
    it 'updates a cat' do
      # create a cat
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first

      # update the cat
      updated_cat_params = {
        cat: {
          name: 'Toasty',
          age: 3,
          enjoys: 'having thumbs'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params

      # create a new variable that redefines the cat instance, since the cat variable is still pointing to the original cat we first created
      updated_cat = Cat.find(cat.id)

      # asserting against the response code
      expect(response).to have_http_status(200)
      # asserting against the payload
      expect(updated_cat.age).to eq 3
    end
    it 'doesnt update a cat without a name' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      updated_cat_params = {
        cat: {
          name: nil,
          age: 3,
          enjoys: 'having thumbs'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p 'update without a name'
      p json['name']
      expect(json['name']).to include "can't be blank"
    end
    it 'doesnt update a cat without an age' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: nil,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p 'update without a name'
      p json['age']
      expect(json['age']).to include "can't be blank"
    end
    it 'doesnt update a cat without an enjoys' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'having thumbs',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: nil,
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)

      # asserting against the response code
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      p 'update without a enjoys'
      p json['enjoys']
      expect(json['enjoys']).to include "can't be blank"
    end
  end

  describe "DELETE /destroy" do
    it 'deletes a cat' do
      # create a cat
      cat_params = {
        cat: {
          name: 'Felix',
          age: 4,
          enjoys: 'Walks in the park.',
          image: 'https://static01.nyt.com/images/2019/07/21/arts/23lionking1/merlin_154880472_6647f53b-1be2-43cd-87e0-ce26ebf1d4ed-superJumbo.jpg'

        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      delete "/cats/#{cat.id}"

      # asserting against the response code
      expect(response).to have_http_status(200)

      cats = Cat.all
      # asserting against the payload
      expect(cats).to be_empty
    end
  end

end