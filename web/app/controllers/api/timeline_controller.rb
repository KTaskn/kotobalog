class Api::TimelineController < ApplicationController
  SIZE = 5
  def get
    offset = params[:offset]
    lastid = params[:lastid]

    if offset and lastid then
      l_sentence = Sentence.where("id <= :id", id: lastid).order(id: :desc).limit(SIZE).offset((offset.to_i - 1) * SIZE)
      offset = offset.to_i + 1
    else
      offset = 2
      l_sentence = Sentence.order(id: :desc).limit(SIZE)
      if l_sentence then
        lastid = l_sentence[0].id
      else
        lastid = 0
      end
    end
    
    ret_sentences = l_sentence.map do |a_sentence|
      {
        'id': a_sentence.id,
        'sentence': a_sentence.sentence,
        'creator': a_sentence.book.creator,
        'publisher': a_sentence.book.publisher,
        'title': a_sentence.book.title,
        'likenum': a_sentence.get_likes()
      }
    end

    render :json => {
      'result': true,
      'sentences': ret_sentences,
      'offset': offset,
      'lastid': lastid
    }
  end
end
