require 'test_helper'

class SentenceTest < ActiveSupport::TestCase
  test "like" do
    SentenceLike.all.delete_all

    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    result = User.signup(name, password, password, email)
    user = User.find_by(name: name)
    
    title = 'test_title'
    creator = 'test_creator'
    publisher = 'test_publisher'
    isbn = 0


    book = Book.create(
        title: title,
        creator: creator,
        publisher: publisher,
        isbn: isbn
    )
    book.save!()

    text = 'text'
    sentence = Sentence.create(
        user: user,
        book: book,
        sentence: text
    )
    sentence.save!()

    sentence1 = Sentence.create(
        user: user,
        book: book,
        sentence: text
    )
    sentence1.save!()

    assert SentenceLike.find_by(user: user).nil?
    assert sentence.like(user) == true
    assert SentenceLike.where(user: user, sentence: sentence).count == 1

    assert sentence.islike(user)
    assert_not sentence1.islike(user)

    assert sentence.like(user) == false
    assert SentenceLike.where(user: user, sentence: sentence).count == 1
    assert sentence.unlike(user) == true
    assert SentenceLike.where(user: user, sentence: sentence).count == 0

    assert_not sentence.islike(user)
    assert_not sentence1.islike(user)

    assert sentence.unlike(user) == false
    assert SentenceLike.where(user: user, sentence: sentence).count == 0
  end

  test "switch like" do
    SentenceLike.all.delete_all
    
    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    result = User.signup(name, password, password, email)
    user = User.find_by(name: name)
    
    title = 'test_title'
    creator = 'test_creator'
    publisher = 'test_publisher'
    isbn = 0


    book = Book.create(
        title: title,
        creator: creator,
        publisher: publisher,
        isbn: isbn
    )
    book.save!()

    text = 'text'
    sentence = Sentence.create(
        user: user,
        book: book,
        sentence: text
    )
    sentence.save!()
    assert SentenceLike.find_by(user: user).nil?
    assert sentence.switch_like(user) == true
    assert SentenceLike.where(user: user, sentence: sentence).count == 1
    assert sentence.switch_like(user) == true
    assert SentenceLike.where(user: user, sentence: sentence).count == 0
  end

  test "like user is null" do
    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    result = User.signup(name, password, password, email)
    user = User.find_by(name: name)
    
    title = 'test_title'
    creator = 'test_creator'
    publisher = 'test_publisher'
    isbn = 0


    book = Book.create(
        title: title,
        creator: creator,
        publisher: publisher,
        isbn: isbn
    )
    book.save!()

    text = 'text'
    sentence = Sentence.create(
        user: user,
        book: book,
        sentence: text
    )
    sentence.save!()
    assert SentenceLike.find_by(user: user).nil?
    assert sentence.like(nil) == false
  end

  test "get like num" do
    SentenceLike.all.delete_all

    name0 = 'name0'
    password0 = 'test_password0'
    email0 = 'test_email0@example.com'
    result0 = User.signup(name0, password0, password0, email0)
    user0 = User.find_by(name: name0)

    name1 = 'name1'
    password1 = 'test_password1'
    email1 = 'test_email1@example.com'
    result1 = User.signup(name1, password1, password1, email1)
    user1 = User.find_by(name: name1)
    
    title = 'test_title'
    creator = 'test_creator'
    publisher = 'test_publisher'
    isbn = 0


    book = Book.create(
        title: title,
        creator: creator,
        publisher: publisher,
        isbn: isbn
    )
    book.save!()

    text = 'text'
    sentence = Sentence.create(
        user: user0,
        book: book,
        sentence: text
    )
    sentence.save!()
    assert sentence.get_likes() == 0
    assert sentence.like(user0) == true
    assert sentence.get_likes() == 1
    assert sentence.like(user1) == true
    assert sentence.get_likes() == 2
  end

  test "get sentencecomment" do
    SentenceLike.all.delete_all

    name0 = 'name0'
    password0 = 'test_password0'
    email0 = 'test_email0@example.com'
    result0 = User.signup(name0, password0, password0, email0)
    user0 = User.find_by(name: name0)

    name1 = 'name1'
    password1 = 'test_password1'
    email1 = 'test_email1@example.com'
    result1 = User.signup(name1, password1, password1, email1)
    user1 = User.find_by(name: name1)
    
    title = 'test_title'
    creator = 'test_creator'
    publisher = 'test_publisher'
    isbn = 0


    book = Book.create(
        title: title,
        creator: creator,
        publisher: publisher,
        isbn: isbn
    )
    book.save!()

    text = 'text'
    sentence = Sentence.create(
        user: user0,
        book: book,
        sentence: text
    )
    sentence.save!()

    comment = 'コメント'

    comment_obj = SentenceComment.create(
      sentence: sentence,
      comment: comment
    )
    comment_obj.save!()

    assert sentence.get_comment().comment == comment
  end
  
end
