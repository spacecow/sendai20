def digit(s); %w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh).index(s)+1 end
def underscore(s); s.gsub(/\s/,'_') end
def zdigit(ordr); digit(ordr)-1 end
def zword(i); %w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh)[i] end

def table_row(tbl="",order)
  return "table##{tbl} tr:nth-child(#{digit order})" unless tbl.blank?
  "table tr:nth-child(#{digit order})"
end

def list_no(lst=nil,order)
  if lst.nil?
    "ul li:nth-child(#{digit order})"
  else
    "ul##{lst} li:nth-child(#{digit order})"
  end
end
def section_no(div=nil,order)
  if div.nil?
    "div:nth-child(#{digit order})"
  else
    "div.#{div}:nth-child(#{digit order})"
  end
end
def field_no(lbl,ordr)
  id = find(:css, "label", :text => lbl)[:for]
  field = find_field(id)
  if field.tag_name == 'textarea'
    "textarea##{id.gsub(/\d/,zdigit(ordr).to_s)}"
  else
    "input##{id.gsub(/\d/,zdigit(ordr).to_s)}"
  end
end

def cat_id(cat,id,order)
  if cat=="listing"
    list_no(id,order) 
  elsif cat=="section"
    section_no(id,order) 
  elsif cat=="field"
    field_no(id,order)
  end
end
