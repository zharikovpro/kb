# frozen_string_literal: true

require "json"
require "fileutils"

class Converter
  # Build a map of id => [parent_ids] by inverting the children arrays.
  def build_parent_map(notes)
    map = {}
    notes.each do |note|
      (note["children"] || []).each do |child_id|
        map[child_id] ||= []
        map[child_id] << note["id"]
      end
    end
    map
  end

  # Generate the file content for a single note given its parent IDs.
  # If there are no parents: just the note's text verbatim.
  # If there are parents: YAML frontmatter with a links array, then a blank
  # line, then the note's text.
  def note_content(note, parent_ids)
    text = note["text"]
    return text if parent_ids.empty?

    lines = ["---", "links:"]
    parent_ids.each { |pid| lines << "  - \"[[#{pid}]]\"" }
    lines << "---"
    lines << ""
    lines << text
    lines.join("\n")
  end

  # Read a .rrrighter JSON file and write one <uuid>.md file per note into
  # output_dir. Each child file references its parents via YAML frontmatter.
  def convert(input_path, output_dir)
    data = JSON.parse(File.read(input_path))
    notes = data["notes"]

    parent_map = build_parent_map(notes)
    FileUtils.mkdir_p(output_dir)

    notes.each do |note|
      parent_ids = parent_map[note["id"]] || []
      content = note_content(note, parent_ids)
      File.write(File.join(output_dir, "#{note['id']}.md"), content)
    end
  end
end
