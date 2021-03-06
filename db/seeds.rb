# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: ENV["ADMIN_NAME"], password: ENV["ADMIN_PASS"], password_confirmation: ENV["ADMIN_PASS"])

article = ["Lorem ipsum dolor sit amet, consectetuer adipiscing elit. 
			Aenean commodo ligula eget dolor. Aenean massa. Cum sociis 
			natoque penatibus et magnis dis parturient montes, nascetur 
			ridiculus mus. Donec quam felis, ultricies nec, pellentesque
			 eu, pretium quis, sem. Nulla consequat massa quis enim. 
			 Donec pede justo, fringilla vel, aliquet nec, vulputate 
			 eget, arcu. In enim justo, rhoncus ut, imperdiet a, 
			 venenatis vitae, justo. Nullam dictum felis eu pede mollis 
			 pretium. Integer tincidunt. Cras dapibus. Vivamus elementum 
			 semper nisi. Aenean vulputate eleifend tellus. Aenean leo 
			 ligula, porttitor eu, consequat vitae, eleifend ac, enim. 
			 Aliquam lorem ante, dapibus in, viverra quis, feugiat a, 
			 tellus. Phasellus viverra nulla ut metus varius laoreet. 
			 Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel 
			 augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. 
			 Etiam rhoncus. Maecenas tempus, tellus eget condimentum 
			 rhoncus, sem quam semper libero, sit amet adipiscing sem 
			 neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar,
			 hendrerit id, lorem. Maecenas nec odio et ante tincidunt 
			 tempus. Donec vitae sapien ut libero venenatis faucibus. 
			 Nullam quis ante. Etiam sit amet orci eget eros faucibus 
			 tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. 
			 Donec sodales sagittis magna. Sed consequat, leo eget 
			 bibendum sodales, augue velit cursus nunc",
		   "Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate 
		    eleifend tellus. Aenean leo ligula, porttitor eu, consequat 
		    vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, 
		    viverra quis, feugiat a, tellus. Phasellus viverra nulla ut 
		    metus varius laoreet. Quisque rutrum. Aenean imperdiet. 
		    Etiam ultricies nisi vel augue. Curabitur ullamcorper 
		    ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, 
		    tellus eget condimentum rhoncus, sem quam semper libero, sit 
		    amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit 
		    vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio 
		    et ante tincidunt tempus. Donec vitae sapien ut libero 
		    venenatis faucibus. Nullam quis ante. Etiam sit amet orci 
		    eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris 
		    sit amet nibh. Donec sodales sagittis magna."]

title = ["First Blog Post", "Second Blog Post"]

category = ["General", "Computer Science"]

article.each_with_index do |a, i|
  Post.create!(title: title[i], category: category[i], content: a)
end