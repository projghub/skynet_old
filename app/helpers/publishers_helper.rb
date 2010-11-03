module PublishersHelper
	def attribute_value_ids_to_hash(attribute_value_ids)
		attributes = {}
		attribute_value_ids.each do |av_id|
			av = AttributeValue.includes(:attribute).where("id = ?", av_id).first
			next if av.nil?
			attributes[av.attribute.name.to_sym] = [] unless attributes.has_key?(av.attribute.name.to_sym)
			attributes[av.attribute.name.to_sym] << av.value
		end
		joined_attributes = {}
		attributes.each do |k,a|
			joined_attributes[k] = a.join(",")
		end
		joined_attributes
	end
end
