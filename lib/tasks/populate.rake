task :populate => :environment do
  50.times do
    user = User.create!(:name => Forgery::Name.full_name,
                        :username => Forgery::Internet.user_name,
                        :email => Forgery::Internet.email_address,
                        :password => Forgery::Basic.password)
    Opinion.create!(:content => Forgery::LoremIpsum.sentences(rand(4)+2),
                    :user_id => user.id)
  end
end
