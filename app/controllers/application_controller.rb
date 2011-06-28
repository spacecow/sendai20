class ApplicationController < ActionController::Base
  include ControllerAuthentication
  include ControllerAuthentication
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to welcome_url, :alert => exception.message
  end
  protect_from_forgery
  before_filter :set_language
  helper_method :current_user, :english?, :ft, :unicode, :message, :chain

  def admin?; current_user.role? :admin end
  def added(s); success(:added,s) end
  def alert(act); t("alert.#{act}") end
  def alert2(act,obj); t("alert.#{act}",:obj=>obj) end
  def chain(s1,s2); "#{s1.to_s}.#{s2.to_s}" end
  def changed(s); success(:changed,s) end
  def created(s); success(:created,s) end
  def deleted(s); success(:deleted,s) end
  def d(s); t(s).downcase end
  def dp(s); pl(s).downcase end
  def english?; I18n.locale == :en end
  def ft(s); t("formtastic.labels.#{s.to_s}") end
  def ftd(s); d("formtastic.labels.#{s.to_s}") end  
  def god?; current_user.role? :god end
  def join(s1,s2); s1+t(:space)+s2 end
  def message(s); t(chain(:message,s)) end
  def notify(act); t("notice.#{act}") end
  def pl(s); t(s).match(/\w/) ? t(s).pluralize : t(s) end  
  def saved(s); success(:saved,s) end
  def success(act,mdl=nil); t("success.#{act}",:obj=>d(mdl)) end
  def success_p(act,mdl); t("success.#{act}",:obj=>dp(mdl)) end
  def success_p(act,owner,mdl); t("success.#{act}",:obj=>t(:possessive,:owner=>owner,:obj=>dp(mdl))) end
  def unicode(s)
    return "" if s.nil? or s.blank?
    s.gsub(/^"/,'').gsub(/"$/,'').split('\u').reject(&:blank?).map{|e| e =~ /^[0-9,a-f]{4}$/ ? e.hex : e.unpack("U*")}.flatten.pack("U*")
  end
  def updated(s); success(:updated,s) end
  def updated_p(s); success_p(:updated,s) end
  def updated_p(s1,s2); success_p(:updated,s1,s2) end

  def toggle_language
    session[:language] = (session[:language] == 'ja' ? 'en' : 'ja')
    redirect_to :back
  end
  
  private

    def current_opinion
      @current_opinion ||= current_user.opinions.order("created_at desc").last if current_user && current_user.opinions.any?
    end
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def current_user_name; current_user && current_user.name end
    def current_user_email; current_user && current_user.email end
    def current_user_affiliation; current_user && current_user.affiliation end
    
    def set_language
      session[:language] = params[:language].to_sym if params[:language]
      I18n.locale = session[:language] || I18n.default_locale
    end
end
