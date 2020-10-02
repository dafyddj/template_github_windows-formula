# frozen_string_literal: true

control 'TEMPLATE subcomponent configuration' do
  title 'should match desired lines'

  describe file('C:\TEMPLATE-subcomponent-formula.conf') do
    it { should be_file }
    it { should be_owned_by 'BUILTIN\Administrators' }
    its('content') do
      should include(
        '# File managed by Salt at '\
        '<salt://TEMPLATE/subcomponent/config/files/default/'\
        'subcomponent-example.tmpl.jinja>.'
      )
    end
    its('content') do
      should include(
        'This is another subcomponent example file from SaltStack '\
        'template-formula.'
      )
    end
  end
end
