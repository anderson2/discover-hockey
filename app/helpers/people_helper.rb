module PeopleHelper
  
  # Returns the Gravatar for the given user.
  def gravatar_for(person, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(person.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    #image_tag(gravatar_url, alt: person.name, class: "gravatar")
    image_tag(gravatar_url, alt: person.name, class: "center")
  end 

  def profile_image_for(person)
    image_tag @person.picture.url if @person.picture?
  end
 
end
