module ApplicationHelper
	
	def gravatar_url(email)
		gravatar = Digest::MD5::hexdigest(email).downcase
		url = "http://gravatar.com/avatar/#{gravatar}.png?s=64"
	end

	def user_name
		current_user.email.split('@')[0]
	end
end
