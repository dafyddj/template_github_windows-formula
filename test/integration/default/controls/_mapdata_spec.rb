# frozen_string_literal: true

# Keep only first 2 digits from Ubuntu finger
mapdata_file = "_mapdata/#{system.platform[:finger].split('.').first}.yaml"

# Load the mapdata from profile https://docs.chef.io/inspec/profiles/#profile-files
mapdata_dump = inspec.profile.file(mapdata_file)

control '`map.jinja` YAML dump' do
  title 'should contain the lines'

  tmp =
    case platform[:family]
    when 'windows'
      'TMP'
    else
      'TMPDIR'
    end

  mapdata_file = file("#{os_env(tmp).content}/salt_mapdata_dump.yaml")

  describe mapdata_file do
    it { should exist }
  end

  mapdata_content = mapdata_file.content.encode(universal_newline: true)

  describe 'File content' do
    it 'should match profile map data exactly' do
      expect(mapdata_content).to eq(mapdata_dump)
    end
  end
end
