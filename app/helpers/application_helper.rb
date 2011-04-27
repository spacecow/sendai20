module ApplicationHelper
  def chain(s1,s2); "#{s1.to_s}.#{s2.to_s}" end
  def create(s); t2(:create,s) end
  def current_language; english? ? t(:japanese) : t(:english) end
  def edit(s); t2(:edit,s) end
  def edit_p(s); tp2(:edit,s) end
  def lbl(s); chain(:label,s) end
  def new(s); t2(:new,s) end
  def pl(s); t(s).match(/\w/) ? t(s).pluralize : t(s) end
  def save(s); t2(:save,s) end
  def submit(s); t2(:submit,s) end
  def sure?; t('message.sure?') end
  def t2(s1,s2); t(lbl(s1), :obj => t(s2)) end
  def tp2(s1,s2); t(lbl(s1), :obj => pl(s2)) end
  def update(s); t2(:update,s) end
  def update_p(s); tp2(:update,s) end
  def verify(s); t2(:verify,s) end
  def view(s); tp2(:view,s) end
  def view_own(s); tp2(:view_own,s) end
end
