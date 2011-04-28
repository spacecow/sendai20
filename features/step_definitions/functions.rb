def digit(s); %w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh).index(s)+1 end
def underscore(s); s.gsub(/\s/,'_') end
def zdigit(ordr); digit(ordr)-1 end
