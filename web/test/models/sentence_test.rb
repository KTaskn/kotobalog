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
    assert SentenceLike.find_by(user: user).nil?
    assert sentence.like(user) == true
    assert SentenceLike.where(user: user).count == 1

    assert sentence.islike(user)

    assert sentence.like(user) == false
    assert SentenceLike.where(user: user).count == 1
    assert sentence.unlike(user) == true
    assert SentenceLike.where(user: user).count == 0

    assert_not sentence.islike(user)

    assert sentence.unlike(user) == false
    assert SentenceLike.where(user: user).count == 0
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
    assert SentenceLike.where(user: user).count == 1
    assert sentence.switch_like(user) == true
    assert SentenceLike.where(user: user).count == 0
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
end
