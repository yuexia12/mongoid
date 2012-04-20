require "spec_helper"

describe Mongoid::Extensions::Date do

  describe ".demongoize" do

    let(:time) do
      Time.utc(2010, 1, 1, 0, 0, 0, 0)
    end

    let(:expected) do
      Date.new(2010, 1, 1)
    end

    it "keeps the date" do
      Date.demongoize(time).should eq(expected)
    end

    it "converts to a date" do
      Date.demongoize(time).should be_a(Date)
    end
  end

  describe ".mongoize" do

    context "when provided a date" do

      let(:date) do
        Date.new(2010, 1, 1)
      end

      let(:evolved) do
        Date.mongoize(date)
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0)
      end

      it "returns the time" do
        evolved.should eq(expected)
      end
    end

    context "when provided a string" do

      let(:date) do
        Date.parse("1st Jan 2010")
      end

      let(:evolved) do
        Date.mongoize(date.to_s)
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      it "returns the string as a time" do
        evolved.should eq(expected)
      end
    end

    context "when provided a float" do

      let(:time) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      let(:float) do
        time.to_f
      end

      let(:evolved) do
        Date.mongoize(float)
      end

      it "returns the float as a time" do
        evolved.should eq(time)
      end
    end

    context "when provided an integer" do

      let(:time) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      let(:integer) do
        time.to_i
      end

      let(:evolved) do
        Date.mongoize(integer)
      end

      it "returns the integer as a time" do
        evolved.should eq(time)
      end
    end

    context "when provided nil" do

      it "returns nil" do
        Date.mongoize(nil).should be_nil
      end
    end
  end

  describe "#mongoize" do

    let(:date) do
      Date.new(2010, 1, 1)
    end

    let(:time) do
      Time.utc(2010, 1, 1, 0, 0, 0, 0)
    end

    it "returns the date as a time at midnight" do
      date.mongoize.should eq(time)
    end
  end
end
