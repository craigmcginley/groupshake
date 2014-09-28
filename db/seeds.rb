xml_doc = Nokogiri::XML(File.open("julius_caesar.xml"))

# Avoid using bang methods in migrations (and seeds is basically a migration)
# A migration that blows up is hard to roll back and hard to roll forward

# If you're going to do this in seeds.rb, then it needs to be idempotent.
# You have to assume people will run it over and over again.
@play = Play.create!(title: xml_doc.xpath("//PLAY/TITLE").text, total_scenes: xml_doc.xpath("//SCENE").count)
@chars = {}

xml_doc.xpath("//SCENE").each do |scene|
  # Pick one processing method - CSS or xpath - and use it consistently
  scene_title = scene.css("TITLE").text
  speeches = scene.css("SPEECH")

  speeches.each do |speech|
    speakers = speech.css("SPEAKER")
    # Extract each of these into a separate named method to better describe your intent
    # Like speaker_name, etc.
    speakers.each do |speaker|
      #What are you trying to accomplish here?
      speaker = speaker.text.split(" ")
      speaker.each do |name|
        name.capitalize!
      end
      speaker = speaker.join(" ")
      line_count = speech.css("LINE").count

      role = @play.roles.find_or_create_by!(name: speaker)
      @chars[role.name] ||= []
      role.lines_spoken += line_count
      if line_count > role.longest_speech
        role.longest_speech = line_count
      end
      role.save
      if !@chars[role.name].include?(scene_title)
        @chars[role.name] << scene_title
      end
    end
  end
end

@chars.each do |char, scenes|
  role = Role.find_by(name: char)
  role.scene_count = scenes.count
  # this is a small enough calculation that it can be done at runtime
  role.scene_percentage = ((role.scene_count.to_f / @play.total_scenes.to_f) * 100).round(2)
  role.save
end

@roles = Role.all
@roles.each do |role|
  # Why bother doing this?
  # What's the harm in showing characters who do not speak?
  if role.lines_spoken == 0 || role.name == "All"
    role.destroy
  end
end
