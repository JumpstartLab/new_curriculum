tags = {
  'terminal' => TerminalTag,
  'irb'      => IRBTag,
  'exercise' => ExerciseTag,
  'archive'  => ArchiveTag
}

tags.each do |tag_name, tag_render|
  Liquid::Template.register_tag(tag_name, tag_render)
end