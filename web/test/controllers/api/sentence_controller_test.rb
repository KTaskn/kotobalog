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
    comment = 'コメント'

    post api_sentence_note_url, params: {
      'name': name,
      'title': title,
      'comment': comment,
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn,
      'sentence': sentence
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
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

    comment_load = SentenceComment.find_by(sentence: sentence_load)
    assert comment_load
    assert comment_load.comment == comment

    post api_sentence_note_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % 'other'
    }
    assert_response :unauthorized


    post api_sentence_note_url, params: {
      'name': name
    }
    assert_response :unauthorized
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
    comment = 'コメント'

    post api_sentence_note_url, params: {
      'name': name,
      'title': title,
      'comment': comment,
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn,
      'sentence': sentence
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
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
    comment = 'コメント'

    post api_sentence_note_url, params: {
      'name': name,
      'title': title,
      'comment': comment,
      'creator': creator,
      'publisher': publisher,
      'isbn': isbn
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']

    book_load = Book.find_by(title: title)
    assert_not book_load
  end

  test "should post getmine" do
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

    get api_sentence_get_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']


    get api_sentence_get_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % 'other'
    }
    assert_response :unauthorized

    get api_sentence_get_url, params: {
      'name': name
    }
    assert_response :unauthorized
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

    get api_sentence_getmine_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']


    get api_sentence_getmine_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % 'other'
    }
    assert_response :unauthorized


    get api_sentence_getmine_url, params: {
      'name': name
    }
    assert_response :unauthorized
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

      comment_load = SentenceComment.find_by(sentence: sentence_load)
      assert comment_load
      assert comment_load.comment == comments[index]

      index += 1
    end

    get api_sentence_getmine_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
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

    get api_sentence_getmine_url, params: {
      'name': name,
      'page': 2,
      'lastid': json['lastid']
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    
    json['sentences'].each do |ent|
      assert ent['id']
      assert ent['sentence'] == sentences[index]
      assert ent['creator'] == creator
      assert ent['publisher'] == publisher
      assert ent['title'] == titles[index]
      assert ent['comment'] == comments[index]
      index -= 1
    end

    get api_sentence_getmine_url, params: {
      'name': name,
      'page': 3,
      'lastid': json['lastid']
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['sentences']
    
  end

  test "sentence controller test like" do
    SentenceLike.all.delete_all
    
    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    access_token = json['access_token']
    
    title = 'test_title'
    creator = 'test_creator'
    publisher = 'test_publisher'
    isbn = 0

    user = User.find_by(name: name)

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

    post api_sentence_like_url, params: {
      'name': name,
      'sentence_id': sentence.id
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    
    assert SentenceLike.where(sentence: sentence).count == 1


    get api_sentence_islike_url, params: {
      'name': name,
      'sentence_id': sentence.id
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['islike']
    assert json['likenum'] == 1

    name2 = 'name2'
    password2 = 'test_password2'
    email2 = 'test_email2@example.com'
    
    post api_user_signup_url, params: {
      'name': name2,
      'password': password2,
      'password_check': password2,
      'email': email2
    }

    json2 = JSON.parse(response.body)
    assert_response :success
    access_token_2 = json2['access_token']

    post api_sentence_like_url, params: {
      'name': name2,
      'sentence_id': sentence.id
    },
    headers: {
      'Authorization': 'Token %s' % access_token_2
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']

    user2 = User.find_by(name: name2)
    assert SentenceLike.where(sentence: sentence).count == 2

    post api_sentence_like_url, params: {
      'name': name,
      'sentence_id': sentence.id
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    
    assert SentenceLike.where(sentence: sentence).count == 1
    assert SentenceLike.where(user: user).count == 0


    get api_sentence_islike_url, params: {
      'name': name,
      'sentence_id': sentence.id
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert_not json['islike']

    post api_sentence_like_url, params: {
      'name': name,
      'sentence_id': ''
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
  end

  test "test get getmine pagenation" do
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


      # 他人のデータも追加する
    name2 = 'test_name_2'
    password2 = 'test_password'
    email2 = 'email_2@example.com'
    post api_user_signup_url, params: {
      'name': name2,
      'password': password2,
      'password_check': password2,
      'email': email2
    }    
    json_other = JSON.parse(response.body)
    assert_response :success
    assert json_other['result']
    assert json_other['access_token']
    access_token_other = json_other['access_token']

  
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
        'sentence': sentences[n],
      },
      headers: {
        'Authorization': 'Token %s' % access_token
      }
      json = JSON.parse(response.body)
      assert_response :success
      assert json['result']

      # 他人のデータも混ぜる
      post api_sentence_note_url, params: {
        'name': name2,
        'title': 'other',
        'comment': 'comment other',
        'creator': 'other',
        'publisher': 'other',
        'isbn': '',
        'sentence': 'other data'
      },
      headers: {
        'Authorization': 'Token %s' % access_token_other
      }
      json_other = JSON.parse(response.body)
      assert_response :success
      assert json_other['result']
    end

    user = User.find_by(name: name)

    index = 0
    Sentence.where(user: user).each do |sentence_load|
      assert sentence_load
      assert sentence_load.sentence == sentences[index]
      assert sentence_load.book == Book.find_by(title: titles[index])

      comment_load = SentenceComment.find_by(sentence: sentence_load)
      assert comment_load
      assert comment_load.comment == comments[index]
      index += 1
    end

    # 呼び出してチェック
    get api_sentence_getmine_url, params: {
      'name': name
    },
    headers: {
      'Authorization': 'Token %s' % access_token
    }
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
    
    get api_sentence_getmine_url, params: {
      'name': name,
      'page': 2,
      'lastid': json['lastid']
    },
    headers: {
      'Authorization': 'Token %s' % access_token
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
      'comment': 'comment other',
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
    get api_sentence_getmine_url, params: {
      'name': name,
      'page': 3,
      'lastid': json['lastid']
    },
    headers: {
      'Authorization': 'Token %s' % access_token
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

  
end
