require 'test_helper'

class Api::TimelineControllerTest < ActionDispatch::IntegrationTest
  test "test get" do
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

    # 呼び出してチェック
    get api_timeline_get_url
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']

    sentences = (0..num).map do |n|
      sprintf('テストセンテンス_%d', n)
    end

    titles = (0..num).map do |n|
      sprintf('タイトル_%d', n)
    end

    comments = (0..num).map do |n|
      sprintf('コメント_%d', n)
    end

    creator = 'テスト作者'
    publisher = 'テストパブリッシャー'
    isbn = ''

    (0..num).each do |n|
      post api_sentence_note_url, params: {
        'name': name,
        'title': titles[n],
        'comment': comments[n],
        'creator': creator,
        'publisher': publisher,
        'isbn': isbn,
        'sentence': sentences[n]
      },
      headers: {
        'Authorization': 'Token %s' % access_token
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

    # 呼び出してチェック
    get api_timeline_get_url
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']

    assert json['sentences'].length == 5

    index = titles.length - 1
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      assert ent['publisher'] == publisher
      assert ent['title'] == titles[index]
      assert ent['likenum'] == 0
      assert ent['comment'] == comments[index]
      index -= 1
    end

    # likeした版
    Sentence.where(user: user).each do |sentence_load|
      assert sentence_load.like(user) == true
    end
    
    # ログイン時
    get api_timeline_get_url
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']

    index = titles.length - 1
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      assert ent['publisher'] == publisher
      assert ent['title'] == titles[index]
      assert ent['likenum'] == 1
      index -= 1
    end
  end

  test "test get pagenation" do
    num = 20

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

    comments = (0..num).map do |n|
      sprintf('コメント_%d', n)
    end

    creator = 'テスト作者'
    publisher = 'テストパブリッシャー'
    isbn = ''

    (0..num).each do |n|
      post api_sentence_note_url, params: {
        'name': name,
        'title': titles[n],
        'comment': comments[n],
        'creator': creator,
        'publisher': publisher,
        'isbn': isbn,
        'sentence': sentences[n]
      },
      headers: {
        'Authorization': 'Token %s' % access_token
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

    # 呼び出してチェック
    get api_timeline_get_url
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    assert json['lastid']
    assert json['numpage'] == 5

    assert json['sentences'].length == 5

    index = titles.length - 1
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      assert ent['publisher'] == publisher
      assert ent['title'] == titles[index]
      assert ent['likenum'] == 0
      assert ent['comment'] == comments[index]
      index -= 1
    end
    
    get api_timeline_get_url, params: {
      'page': 2,
      'lastid': json['lastid']
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    assert json['lastid'] == json['lastid']
    assert json['numpage'] == 5

    assert json['sentences'].length == 5

    index = titles.length - (1 + 5)
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      assert ent['publisher'] == publisher
      assert ent['title'] == titles[index]
      assert ent['likenum'] == 0
      assert ent['comment'] == comments[index]
      index -= 1
    end

    # 途中でデータを挿入
    post api_sentence_note_url, params: {
      'name': name,
      'title': 'other',
      'comment': 'comments',
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn,
      'sentence': 'other'
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    assert_response :success

    # 途中挿入されたものが無視されて前回からのページネーションができてるかチェック
    get api_timeline_get_url, params: {
      'page': 3,
      'lastid': json['lastid']
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    assert json['lastid'] == json['lastid']
    assert json['numpage'] == 5

    assert json['sentences'].length == 5

    index = titles.length - (1 + 10)
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      assert ent['publisher'] == publisher
      assert ent['title'] == titles[index]
      assert ent['likenum'] == 0
      assert ent['comment'] == comments[index]
      index -= 1
    end
  end

  test "test get timeline not comment" do
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

    # 呼び出してチェック
    get api_timeline_get_url
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']

    assert json['sentences'][0]['comment'] == ''
  end

end
