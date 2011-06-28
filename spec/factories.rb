# -*- coding: utf-8 -*-

Factory.define :locale do |f|
  f.title "ja"
end

Factory.define :opinion do |f|
  f.association :user
  f.content "Default factory content"
end

Factory.define :reset do |f|
end

Factory.define :translation do |f|
  f.association :locale
  f.key "welcome"
  f.value "ようこそ"
end

Factory.define :user do |f|
  f.prefecture "宮城県"
  f.address "Aoba-ku, Katahira"
  f.sequence(:email){|n| "default#{n}@email.com"}
  f.name "Factory default name"
  f.password "abc123"
end

