require 'test_helper'

class Api::SentenceControllerTest < ActionDispatch::IntegrationTest
  test "should post note" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']

    sentence = 'テストセンテンス'
    creator = 'テスト作者'
    title = ''
    publisher = ''
    isbn = ''

    post api_sentence_note_url, params: {
      'name': name,
      'access_token': json['access_token'],
      'title': title,
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn,
      'sentence': sentence
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']

    book_load = Book.find_by(title: title)
    assert book_load
    assert book_load.title == title
    assert book_load.creator == creator
    assert book_load.publisher == publisher
    assert book_load.isbn == isbn

    user = User.find_by(name: name)
    sentence_load = Sentence.find_by(user: user)
    assert sentence_load
    assert sentence_load.sentence == sentence
    assert sentence_load.book == book_load

    post api_sentence_note_url, params: {
      'name': name,
      'access_token': 'other'
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
  end

  test "sentence note error" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']

    sentence = ''
    creator = 'テスト作者'
    title = ''
    publisher = ''
    isbn = ''

    post api_sentence_note_url, params: {
      'name': name,
      'access_token': json['access_token'],
      'title': title,
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn,
      'sentence': sentence
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']

    book_load = Book.find_by(title: title)
    assert_not book_load

    user = User.find_by(name: name)
    sentence_load = Sentence.find_by(user: user)
    assert_not sentence_load
  end

  test "note book error" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']

    creator = ''
    title = ''
    publisher = ''
    isbn = ''

    post api_sentence_note_url, params: {
      'name': name,
      'access_token': json['access_token'],
      'title': title,
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']

    book_load = Book.find_by(title: title)
    assert_not book_load
  end

  test "should post get" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']

    post api_sentence_get_url, params: {
      'name': name,
      'access_token': json['access_token']
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']


    post api_sentence_get_url, params: {
      'name': name,
      'access_token': 'other'
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
  end

  test "should post getmine accesstoken" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']

    post api_sentence_getmine_url, params: {
      'name': name,
      'access_token': json['access_token'],
      'offset': 0
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']


    post api_sentence_getmine_url, params: {
      'name': name,
      'access_token': 'other'
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
  end

  test "test getmine" do
    num = 10

    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']
    access_token = json['access_token']

    sentences = (0..num).map do |n|
      sprintf('テストセンテンス_%d', n)
    end

    titles = (0..num).map do |n|
      sprintf('タイトル_%d', n)
    end

    creator = 'テスト作者'
    publisher = 'テストパブリッシャー'
    isbn = ''

    (0..num).each do |n|
      post api_sentence_note_url, params: {
        'name': name,
        'access_token': access_token,
        'title': titles[n],
        'creator': creator,
        'publisher': publisher,
        'isbn': isbn,
        'sentence': sentences[n]
      }
      json = JSON.parse(response.body)
      assert_response :success
      assert json['result']
    end

    user = User.find_by(name: name)

    index = 0
    Sentence.where(user: user).each do |sentence_load|
      assert sentence_load
      assert sentence_load.sentence == sentences[index]
      assert sentence_load.book == Book.find_by(title: titles[index])
      index += 1
    end

    post api_sentence_getmine_url, params: {
      'name': name,
      'access_token': access_token,
      'offset': 0
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']

    assert json['sentences'].length == 5
    assert json['is_over'] == false

    index = titles.length - 1
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      index -= 1
    end

    post api_sentence_getmine_url, params: {
      'name': name,
      'access_token': access_token,
      'offset': 1
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    assert json['is_over'] == false
      
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      index -= 1
    end

    post api_sentence_getmine_url, params: {
      'name': name,
      'access_token': access_token,
      'offset': 2
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    assert json['is_over'] == true
      
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      index -= 1
    end
    
  end
end
