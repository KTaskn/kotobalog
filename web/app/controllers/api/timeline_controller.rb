class Api::TimelineController < ApplicationController
  SIZE = 5
  def get
    l_sentence = Sentence.order(id: :desc).limit(SIZE)
    ret_sentences = l_sentence.map do |a_sentence|
      {
        'id': a_sentence.id,
        'sentence': a_sentence.sentence,
        'creator': a_sentence.book.creator,
        'publisher': a_sentence.book.publisher,
        'title': a_sentence.book.title
      }
    end

    render :json => {
      'result': true,
      'sentences': ret_sentences
    }
  end
end
