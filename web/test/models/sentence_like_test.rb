require 'test_helper'

class SentenceLikeTest < ActiveSupport::TestCase
  test "uniquness" do
    SentenceLike.all.delete_all

    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    result = User.signup(name, password, password, email)
    user = User.find_by(name: name)

    name2 = 'name2'
    password2 = 'test_password2'
    email2 = 'test_email2@example.com'
    result2 = User.signup(name2, password2, password2, email2)
    user2 = User.find_by(name: name2)
    
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
    assert SentenceLike.count == 1
    assert sentence.like(user2) == true
    assert SentenceLike.count == 2
  end
end
