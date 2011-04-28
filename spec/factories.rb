Factory.define :user do |f|
  f.sequence(:username){|n| "username#{n}"}
  f.sequence(:email){|n| "default#{n}@email.com"}
  f.name "Factory default name"
  f.password "abc123"
end

Factory.define :opinion do |f|
  f.association :user
  f.content "Default factory content"
end
