class Api::SentenceController < AuthenticationController
  protect_from_forgery

  def note
    name = params[:name]
    title = params[:title]
    comment = params[:comment]
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

      obj_sentence = Sentence.create(
        user: user,
        book: book,
        sentence: sentence
      )
      obj_sentence.save!()

      obj_comment = SentenceComment.create(
        sentence: obj_sentence,
        comment: comment
      )
      obj_comment.save!()
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
    page = params[:page]
    lastid = params[:lastid]

    user = User.find_by(name: name)

    if page and lastid then
      l_sentence = Sentence.where("id <= :id", id: lastid).where(user: user).order(id: :desc).limit(MINE_SIZE).offset((page.to_i - 1) * MINE_SIZE)
      numpage = (Sentence.where("id <= :id", id: lastid).where(user: user).count / MINE_SIZE.to_f).ceil
    else
      l_sentence = Sentence.where(user: user).order(id: :desc).limit(MINE_SIZE)
      if l_sentence.empty? then
        lastid = 0
        numpage = 1
      else
        lastid = l_sentence[0].id
        numpage = (Sentence.where(user: user).count / MINE_SIZE.to_f).ceil
      end
    end

    ret_sentences = l_sentence.map do |a_sentence|
      {
        'id': a_sentence.id,
        'sentence': a_sentence.sentence,
        'creator': a_sentence.book.creator,
        'publisher': a_sentence.book.publisher,
        'title': a_sentence.book.title,
        'likenum': a_sentence.get_likes(),
        'comment': a_sentence.get_comment().comment
      }
    end

    render :json => {
      'result': true,
      'sentences': ret_sentences,      
      'lastid': lastid,
      'numpage': numpage
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
    likenum = 0
    if not sentence_id.blank? then
      sentence = Sentence.find(sentence_id)
      user = User.find_by(name: name)

      if sentence and user then
        ret = sentence.islike(user)
      end

      if sentence then
        likenum = sentence.get_likes()
      end
    end
    
    render :json => {
      'result': true,
      'islike': ret,
      'likenum': likenum
    }
  end
end
