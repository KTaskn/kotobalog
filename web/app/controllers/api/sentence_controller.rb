class Api::SentenceController < AuthenticationController
  protect_from_forgery

  def note
    name = params[:name]
    title = params[:title]
    creator = params[:creator]
    publisher = params[:publisher]
    isbn = params[:isbn]
    sentence = params[:sentence]

    user = User.find_by(name: name)

    ActiveRecord::Base.transaction do
      # 文章が保存されていない場合は、書籍も保存しないトランザクション
      book = Book.create(
        title: title,
        creator: creator,
        publisher: publisher,
        isbn: isbn
        )
      book.save!()

      sentence = Sentence.create(
        user: user,
        book: book,
        sentence: sentence
      )
      sentence.save!()
    end

    render :json => {
      'result': true
    }

    rescue => ex
      render :json => {
        'result': false
      }
  end

  def get
    render :json => {
      'result': true
    }
  end

  MINE_SIZE = 5
  def getmine
    name = params[:name]
    offset = params[:offset].to_i()
    user = User.find_by(name: name)
    l_sentence = Sentence.where(user: user).order(id: :desc).limit(MINE_SIZE).offset(offset * MINE_SIZE)
    is_over = Sentence.where(user: user).count <= (offset + 1) * MINE_SIZE

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
      'sentences': ret_sentences,
      'is_over': is_over
    }
  end

  def like
    name = params[:name]
    sentence_id = params[:sentence_id]
  
    ret = false
    if not sentence_id.blank? then
      sentence = Sentence.find(sentence_id)
      user = User.find_by(name: name)

      if sentence and user then
        ret = sentence.switch_like(user)
      end
    end
      
    render :json => {
      'result': ret
    }
  end

  def islike
    name = params[:name]
    sentence_id = params[:sentence_id]
  
    ret = false
    if not sentence_id.blank? then
      sentence = Sentence.find(sentence_id)
      user = User.find_by(name: name)

      if sentence and user then
        ret = sentence.islike(user)
      end
    end
      
    render :json => {
      'result': true,
      'islike': ret
    }
  end
end
