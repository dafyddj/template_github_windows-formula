# frozen_string_literal: true

control 'TEMPLATE configuration' do
  title 'should match desired lines'

  describe file('C:\template-formula.conf') do
    it { should be_file }
    it { should be_owned_by 'BUILTIN\Administrators' }
    its('content') do
      should include(
        'This is another example file from SaltStack template-formula.'
      )
    end
    its('content') { should include '"added_in_pillar": "pillar_value"' }
    its('content') { should include '"added_in_defaults": "defaults_value"' }
    its('content') { should include '"added_in_lookup": "lookup_value"' }
    its('content') { should include '"config": "C:\\\\template-formula.conf"' }
    its('content') { should include '"lookup": {"added_in_lookup": "lookup_value",' }
    its('content') { should include '"pkg": {"name": "' }
    its('content') { should include '"service": {"name": "' }
    its('content') do
      should include(
        '"tofs": {"files_switch": ["any/path/can/be/used/here", "id", '\
        '"roles", "osfinger", "os", "os_family"], "source_files": '\
        '{"TEMPLATE-config-file-file-managed": ["example.tmpl.jinja"], '\
        '"TEMPLATE-subcomponent-config-file-file-managed": '\
        '["subcomponent-example.tmpl.jinja"]}'
      )
    end
    its('content') { should include '"arch": "amd64"' }
    its('content') { should include '"winner": "pillar"}' }
    its('content') { should include 'winner of the merge: pillar' }
  end
end
