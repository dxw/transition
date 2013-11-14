require 'spec_helper'

describe 'HostPresenter' do
  describe '#as_hash' do
    let(:site) { create(:site_with_default_host) }
    let(:host) { site.hosts.first }
    subject { HostPresenter.new(host).as_hash }

    it { should have_key(:hostname) }

    context 'when aka is false (by default)' do
      subject { HostPresenter.new(host).as_hash }
      its([:hostname]) { should eql(host.hostname) }
    end

    context 'when aka is true' do
      subject { HostPresenter.new(host, aka: true).as_hash }
      its([:hostname]) { should eql(host.aka_hostname) }
    end

    it { should have_key(:managed_by_transition) }
    its([:managed_by_transition]) { should be_true }
  end
end
