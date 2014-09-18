xml_doc = Nokogiri::XML(File.open("julius_caesar.xml"))

@play = Play.create(title: xml_doc.xpath("//PLAY/TITLE").text, total_scenes: xml_doc.xpath("//SCENE").count)
@chars = {}

xml_doc.xpath("//SCENE").each do |scene|
  scene_title = scene.css("TITLE").text
  speeches = scene.css("SPEECH")

  speeches.each do |speech|
    speakers = speech.css("SPEAKER")
    speakers.each do |speaker|
      speaker = speaker.text.split(" ")
      speaker.each do |name|
        name.capitalize!
      end
      speaker = speaker.join(" ")
      line_count = speech.css("LINE").count

      role = @play.roles.find_or_create_by(name: speaker)
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
  role.scene_percentage = ((role.scene_count.to_f / @play.total_scenes.to_f) * 100).round(2)
  role.save
end

@roles = Role.all
@roles.each do |role|
  if role.lines_spoken == 0 || role.name == "All"
    role.destroy
  end
end
