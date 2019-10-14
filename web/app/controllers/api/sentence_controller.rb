class Api::SentenceController < ApplicationController
  protect_from_forgery
  before_action :check_access_token

  private def check_access_token
    name = params[:name]
    str_access_token = params[:access_token]
    user = User.find_by(name: name)
    if user && user.check_access_token(str_access_token) then
      return 
    else
      render :json => {
        'result': false
      }
    end
  end

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

  def getmine
    render :json => {
      'result': true
    }
  end
end
