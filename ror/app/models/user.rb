require 'digest'

class User < ActiveRecord::Base
	belongs_to :account

	def hash_password(password)
		User.hash_password_and_salt password, self.salt
	end

	def password_matches?(password)
		logger.debug('password:      '+hash_password(password))
		logger.debug('password_hash: '+self.password_hash)
		hash_password(password) == self.password_hash
	end

	def self.hash_password_and_salt(password, salt)
		Digest::SHA1.hexdigest(salt+password)
	end
end
