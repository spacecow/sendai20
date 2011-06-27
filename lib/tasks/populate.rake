task :populate => :environment do
  50.times do
    user = User.create!(:name => Forgery::Name.full_name,
                        :address => "#{Forgery::Address.country}, #{Forgery::Address.street_address}",
                        :prefecture => Forgery::Address.state,
                        :email => Forgery::Internet.email_address,
                        :password => Forgery::Basic.password)
    Opinion.create!(:content => Forgery::LoremIpsum.sentences(rand(20)+10),
                    :user_id => user.id)
  end
end
