require 'spec_helper'

describe Normalize do
  it 'is included in ActiveRecord::Base' do
    ActiveRecord::Base.should include(Normalize)
  end
  
  describe 'instance methods' do
    class NormalizedObject
      include Normalize
    end
    
    let(:normalizer) { NormalizedObject.new }
    
    describe '#normalize_value' do
      it 'normalizes the given value with the given normalizer' do
        normalizer.normalize_value("string", -> input { input.upcase }).should == "STRING"
      end
    end
  end
  
  context 'ActiveRecord Model' do
    class Book < ActiveRecord::Base
      normalize :title,  TitleNormalizer
      normalize :author, with: AuthorNormalizer
      normalize :isbn,   with: -> isbn { isbn.gsub(/[^0-9]/, '') }
    end
    
    let(:object) { Book.new }
    
    it 'normalizes values with a normalizer class' do
      object.title = 'A Bugs Life'
      object.title.should == 'A BUGS LIFE'
    end

    it 'normalizes values with a normalizer class specified with an options hash' do
      object.author = 'jack jones'
      object.author.should == 'Jack Jones'
    end

    it 'normalizes values with a lambda specified with an options hash' do
      object.isbn = '123-456-7890'
      object.isbn.should == '1234567890'
    end
  end
  
  context 'Ruby Object' do
    class Magazine
      include Normalize
      
      attr_accessor :title
      normalize :title, TitleNormalizer
    end
    
    let(:object) { Magazine.new }
    
    it 'normalizes values with a normalizer class' do
      object.title = 'A Bugs Life'
      object.title.should == 'A BUGS LIFE'
    end
  end
end
