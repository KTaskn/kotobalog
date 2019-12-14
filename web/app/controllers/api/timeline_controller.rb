class Api::TimelineController < ApplicationController
  SIZE = 5
  def get
    page = params[:page]
    lastid = params[:lastid]

    if page and lastid then
      l_sentence = Sentence.where("id <= :id", id: lastid).order(id: :desc).limit(SIZE).offset((page.to_i - 1) * SIZE)
      numpage = (Sentence.where("id <= :id", id: lastid).count / SIZE.to_f).ceil
    else
      l_sentence = Sentence.order(id: :desc).limit(SIZE)
      if l_sentence.empty? then
        lastid = 0
        numpage = 1
      else
        lastid = l_sentence[0].id
        numpage = (Sentence.count / SIZE.to_f).ceil
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
      'lastid': lastid,
      'numpage': numpage
    }
  end
end
