require 'rails_helper'

RSpec.describe 'Women API', type: :request do

	# initialize test data
	let!(:women) { create_list(:woman, 5)}
	let(:woman_id) { women.first.id }

	#Test suite for GET /women
	describe 'GET /women' do 
		# make HTTP get request before each example
		before { get '/women'}

		it 'returns women' do 
			#note 'json' is a custom helper to parse JSON requests
			expect(json).not_to be_empty
			expect(json.size).to eq(5)
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end

	#Test suite for GET /women/:id
	describe 'GET /women/:id' do
		before {get "/women/#{woman_id}"}

		context 'when the record exists' do
			it 'returns the woman' do
				expect(json).not_to be_empty
				expect(json['id']).to eq(woman_id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:woman_id) {100}

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			 it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Woman/)
      end
		end
	end

	#Test suite for POST /women
	describe 'POST /women' do
		let (:valid_attributes) { {name: 'Perri Lapidus', bio: 'I am a developer', image_src: 'https://lorempixel.com/50/60'}}

		context 'when the request is valid' do
			before {post '/women', params: valid_attributes}

			it 'creates a woman' do 
				expect(json['name']).to eq('Perri Lapidus')
			end

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when request is invalid' do

			before { post '/women', params: { bio: 'this is a bio'} }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
				expect(response.body)
					.to match(/Validation failed: Name can't be blank/)
			end
		end
	end

	# Test suite for PUT /women/:id
	describe 'PUT /women/:id' do
		let(:valid_attributes) { { name: 'Barack Obama' } }

		context 'when the record exists' do
			before { put "/women/#{woman_id}", params: valid_attributes }

			it 'updates the record' do
				expect(response.body).to be_empty
			end

			it 'returns status code 204' do
 				expect(response).to have_http_status(204)
			end
		end
	end

	#Test suite for DELETE /women/:id
	describe 'DELETE /women/:id' do
		before {delete "/women/#{woman_id}"}

		it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
	end

end