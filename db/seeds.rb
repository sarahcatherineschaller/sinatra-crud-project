role_list = {
	"Math Teacher" => {
		:department => "Mathematics"
	},
	"English Teacher" => {
		:department => "English"
	}, 
	"Science Teacher" => {
		:department => "Science"
	},
	"Head of School" => {
		:department => "Administration"
	}
}

role_list.each do |name, role_hash|
	r = Role.new 
	r.name = name
	role_hash.each do |attribute, value|
		r[attribute] = value 
	end 
	r.save 
end