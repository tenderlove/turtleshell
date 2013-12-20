require 'turtleshell'

describe 'TurtleShell:Device behavior' do
  it 'should return the name' do
    TurtleShell::RTLSDR.
      should_receive(:nth_device).
      and_return({:name => 'slippery-slope'})

    expect(TurtleShell::Device.new(0).name).to eq('slippery-slope')
  end
end

describe 'creating devices' do
  describe 'finding a device by index' do
    before do
      TurtleShell.
        should_receive(:count_of_devices).
        and_return(751)
    end

    it 'should create a new device' do
      TurtleShell::RTLSDR.
        should_receive(:nth_device).
        with(750).
        and_return({:name => 'ill-sorted-limbic-system'})

      expect(TurtleShell::Device.nth_device(750)).to be_an_instance_of TurtleShell::Device
    end

    it 'should raise an ArgumentError when the index is out of bounds' do
      expect { TurtleShell::Device.nth_device(751) }.
        to raise_error(ArgumentError, 'Index out of bounds')
    end
  end

  describe 'finding a device by name' do
    before do
      TurtleShell.
        should_receive(:all_devices).
        and_return(['electro-positive-self-activity', 'dry-shod-leze-majesty'])
    end

    it 'should create a new device' do
      TurtleShell::RTLSDR.
        should_receive(:nth_device).
        with(1).
        and_return({:name => 'dry-shod-leze-majesty'})

      expect(TurtleShell::Device.device_with_name('dry-shod-leze-majesty')).
        to be_an_instance_of TurtleShell::Device
    end

    it 'should raise an ArgumentError when there is matching device' do
      expect { TurtleShell::Device.device_with_name('clincher-built-parity-check') }.
        to raise_error(ArgumentError, 'No device with that name')
    end
  end

  describe 'creating a new device' do
    it 'should create a new device' do
      TurtleShell::RTLSDR.
        should_receive(:nth_device).
        with(437).
        and_return({:name => 'self-applying-cat-silver'})

      expect(TurtleShell::Device.new(437)).to be_an_instance_of TurtleShell::Device
    end

    it 'should raise an error if the first argument is not an integer' do
      expect { TurtleShell::Device.new('a') }.
        to raise_error ArgumentError, 'TurtleShell::Device.new expects a number'

      expect { TurtleShell::Device.new(nil) }.
        to raise_error ArgumentError, 'TurtleShell::Device.new expects a number'
    end
  end
end

describe 'device attribues' do
  before do
    TurtleShell::RTLSDR.
      should_receive(:nth_device).
      with(0).
      and_return({
        :name => 'self-applying-cat-silver',
        :sample_rate => 666,
        :center_frequency => 70e6,
        :gain => :auto,
      })

    @device = TurtleShell::Device.new(0)
  end

  describe 'setting the sample rate' do
    it 'gets and sets the value' do
      expect(@device.sample_rate).to eq(666)

      @device.sample_rate(12)
      expect(@device.sample_rate).to eq(12)
    end
  end

  describe 'setting the center frequency' do
    it 'is not implemented yet' do
      expect(@device.center_frequency).to eq(70e6)

      @device.center_frequency(12e12)
      expect(@device.center_frequency).to eq(12e12)
    end
  end

  describe 'setting the gain' do
    it 'is not implemented yet' do
      expect(@device.gain).to eq(:auto)

      @device.gain(4)
      expect(@device.gain).to eq(4)
    end
  end
end
