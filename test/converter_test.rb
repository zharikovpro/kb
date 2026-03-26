# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require "fileutils"
require "json"
require_relative "../lib/converter"

class ConverterTest < Minitest::Test
  def setup
    @c = Converter.new
  end

  # =========================================================
  # GROUP 1: build_parent_map
  # =========================================================

  def test_build_parent_map_root_has_no_entry
    notes = [{ "id" => "root", "text" => "/" }]
    map = @c.build_parent_map(notes)
    assert_nil map["root"]
  end

  def test_build_parent_map_child_references_parent
    notes = [
      { "id" => "parent", "text" => "Parent", "children" => ["child"] },
      { "id" => "child", "text" => "Child" }
    ]
    map = @c.build_parent_map(notes)
    assert_includes map["child"], "parent"
  end

  def test_build_parent_map_multiple_parents
    notes = [
      { "id" => "p1", "text" => "P1", "children" => ["child"] },
      { "id" => "p2", "text" => "P2", "children" => ["child"] },
      { "id" => "child", "text" => "Child" }
    ]
    map = @c.build_parent_map(notes)
    assert_includes map["child"], "p1"
    assert_includes map["child"], "p2"
  end

  def test_build_parent_map_note_without_children_adds_nothing
    notes = [
      { "id" => "leaf", "text" => "Leaf" }
    ]
    map = @c.build_parent_map(notes)
    assert_nil map["leaf"]
  end

  # =========================================================
  # GROUP 2: note_content
  # =========================================================

  def test_note_content_no_parents_returns_just_text
    note = { "id" => "abc", "text" => "Just some text" }
    assert_equal "Just some text", @c.note_content(note, [])
  end

  def test_note_content_one_parent_has_frontmatter
    note = { "id" => "child", "text" => "Child text" }
    content = @c.note_content(note, ["parent-uuid"])
    assert_match(/\A---\n/, content)
    assert_includes content, "links:"
    assert_includes content, '- "[[parent-uuid]]"'
    assert_includes content, "---\n"
  end

  def test_note_content_one_parent_body_after_frontmatter
    note = { "id" => "child", "text" => "Child text" }
    content = @c.note_content(note, ["parent-uuid"])
    fm_end = content.index("---\n", 4) + 4
    body = content[fm_end..]
    assert_equal "\nChild text", body
  end

  def test_note_content_multiple_parents_lists_all
    note = { "id" => "child", "text" => "Child" }
    content = @c.note_content(note, ["p1-uuid", "p2-uuid"])
    assert_includes content, '- "[[p1-uuid]]"'
    assert_includes content, '- "[[p2-uuid]]"'
  end

  def test_note_content_no_parents_no_frontmatter_block
    note = { "id" => "root", "text" => "/" }
    content = @c.note_content(note, [])
    refute_includes content, "---"
    refute_includes content, "links:"
  end

  def test_note_content_multiline_text_preserved
    text = "Line one\n\nLine two\nLine three"
    note = { "id" => "x", "text" => text }
    content = @c.note_content(note, [])
    assert_equal text, content
  end

  # =========================================================
  # GROUP 3: convert integration
  # =========================================================

  FIXTURE_JSON = JSON.generate({
    "notes" => [
      {
        "id" => "root-id",
        "text" => "/",
        "children" => ["child-a", "child-b"]
      },
      {
        "id" => "child-a",
        "text" => "[Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy)"
      },
      {
        "id" => "child-b",
        "text" => "Keep it simple"
      }
    ]
  })

  def with_temp_convert
    Dir.mktmpdir do |tmp|
      input = File.join(tmp, "test.rrrighter")
      output = File.join(tmp, "obsidian")
      File.write(input, FIXTURE_JSON)
      @c.convert(input, output)
      yield output
    end
  end

  def test_convert_creates_output_directory
    with_temp_convert do |output|
      assert Dir.exist?(output)
    end
  end

  def test_convert_creates_uuid_named_files
    with_temp_convert do |output|
      assert File.exist?(File.join(output, "root-id.md"))
      assert File.exist?(File.join(output, "child-a.md"))
      assert File.exist?(File.join(output, "child-b.md"))
    end
  end

  def test_convert_root_file_has_no_frontmatter
    with_temp_convert do |output|
      content = File.read(File.join(output, "root-id.md"))
      refute_includes content, "---"
      assert_equal "/", content
    end
  end

  def test_convert_child_file_has_parent_link
    with_temp_convert do |output|
      content = File.read(File.join(output, "child-a.md"))
      assert_includes content, '- "[[root-id]]"'
    end
  end

  def test_convert_file_count_equals_note_count
    with_temp_convert do |output|
      files = Dir.glob(File.join(output, "*.md"))
      assert_equal 3, files.length
    end
  end
end
