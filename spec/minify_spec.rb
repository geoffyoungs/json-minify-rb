$: << File.dirname(__FILE__)+"../lib"

require 'json/minify'

describe JSON::Minify do
  it "should remove whitespace from JSON" do
    expect(JSON.minify("{ }")).to eql("{}")
    expect(JSON.minify(%Q<{"foo": "bar"\n}\n>)).to eql(%Q<{"foo":"bar"}>)
  end

  it "should remove comments from JSON" do
    expect(JSON.minify("{ /* foo */ } /* bar */")).to eql("{}")
    expect(JSON.minify(%Q<{"foo": "bar"\n}\n // this is a comment>)).to eql(%Q<{"foo":"bar"}>)
  end

  it "should throw a SyntaxError on invalid JSON" do
    expect { JSON.minify("{ /* foo */ } /* bar ") }.to raise_error(SyntaxError)
    expect { JSON.minify(%Q<{ "foo": new Date(1023) }>) }.to raise_error(SyntaxError)
  end

  it "should cope with the example from https://github.com/getify/JSON.minify" do
    expect(JSON.minify( %Q'{ /* comment */ "foo": 42 \n }' )).to eql('{"foo":42}')
  end
end
