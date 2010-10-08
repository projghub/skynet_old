require 'digest/sha1'

class User < ActiveRecord::Base
	belongs_to :account
	attr_accessor :password, :password_confirmation
	attr_protected :account_id, :password_hash, :salt
	validates_presence_of :account_id
	validates_uniqueness_of :username
	validates_confirmation_of :password
	validates_presence_of :password, :password_confirmation, :on => :create
	validates_format_of :email, :with => /\A(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}\Z/
	after_validation :set_password

	def hash_password(password)
		User.hash_password_and_salt password, self.salt
	end

	def password_matches?(password)
		hash_password(password) == self.password_hash
	end

	def set_password
		self.salt = Digest::SHA1.hexdigest(Time.now.to_s) unless self.salt?
		self.password_hash = hash_password(self.password)
	end

	def self.authenticate(username, password)
		user = User.joins(:account).where("users.username = ? AND users.enabled = ? AND accounts.enabled = ?", username, true, true).first rescue nil
		return nil if user.nil? || !user.password_matches?(password)
		user
	end

	def self.hash_password_and_salt(password, salt)
		Digest::SHA1.hexdigest(salt+password)
	end
end
