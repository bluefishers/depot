module StoreHelper
	def hidden_div_if (condition, attri = {}, &block)
		if condition
			attri["style"] = "display: none"
		end
		content_tag(:div, attri, nil, true, &block)
	end
end
