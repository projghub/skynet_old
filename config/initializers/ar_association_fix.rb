class ActiveRecord::Associations::AssociationProxy
	def raise_on_type_mismatch(record)
		if record.class.to_s != @reflection.class_name
			message = "#{@reflection.class_name} expected, got #{record.class}"
			raise ActiveRecord::AssociationTypeMismatch, message
		end
	end
end
