# encoding: UTF-8

require 'spec_helper'

module ICU
  describe Lib do
    describe 'error checking' do
      let(:return_value) { double }

      context 'upon success' do
        it 'returns the block result' do
          expect(Lib.check_error { |status| return_value }).to eq return_value
          expect(Lib.check_error { |status| status.write_int(0); return_value }).to eq return_value
        end
      end

      context 'upon failure' do
        it 'raises an error' do
          expect { Lib.check_error { |status| status.write_int(1) } }.to raise_error ICU::Error, /U_.*_ERROR/
        end
      end

      context 'upon warning' do
        before(:each) { @verbose = $VERBOSE }
        after(:each) { $VERBOSE = @verbose }

        context 'when warnings are enabled' do
          before(:each) { $VERBOSE = true }

          it 'prints to STDERR and returns the block result' do
            expect($stderr).to receive(:puts) { |message| expect(message).to match /U_.*_WARNING/ }
            expect(Lib.check_error { |status| status.write_int(-127); return_value }).to eq return_value
          end
        end

        context 'when warnings are disabled' do
          before(:each) { $VERBOSE = false }

          it 'returns the block result' do
            expect($stderr).not_to receive(:puts)
            expect(Lib.check_error { |status| status.write_int(-127); return_value }).to eq return_value
          end
        end
      end
    end

    if Gem::Version.new('4.2') <= Gem::Version.new(Lib.version)
      describe 'CLDR version' do
        subject { Lib.cldr_version }

        it { expect(subject).to be_a Lib::VersionInfo }
        it('is populated') { expect(subject.to_a).not_to eq [0,0,0,0] }
      end
    end

    describe 'ICU version' do
      subject { Lib.version }

      it { expect(subject).to be_a Lib::VersionInfo }
      it('is populated') { expect(subject.to_a).not_to eq [0,0,0,0] }
    end
  end
end
