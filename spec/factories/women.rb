FactoryBot.define do
	factory :woman do
		name { Faker::Seinfeld.character }
		bio { Faker::Seinfeld.quote }
		image_src { Faker::LoremPixel.image("400x400") }
	end
end