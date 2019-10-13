require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "parse_xml" do
    xml_code = <<-EOS
<searchRetrieveResponse xmlns="http://www.loc.gov/zing/srw/">
<version>1.2</version>
<numberOfRecords>1</numberOfRecords>
<nextRecordPosition>0</nextRecordPosition>
<extraResponseData>
<facets> <lst name="REPOSITORY_NO"> <int name="R100000002">1</int> </lst> <lst name="NDC"> <int name="4">1</int> </lst> <lst name="ISSUED_DATE"> <int name="2018">1</int> </lst> <lst name="LIBRARY"> <int name="国立国会図書館">1</int> </lst> </facets>
</extraResponseData>
<records>
<record>
<recordSchema>info:srw/schema/1/dc-v1.1</recordSchema>
<recordPacking>string</recordPacking>
<recordData>
<srw_dc:dc xmlns:srw_dc="info:srw/schema/1/dc-v1.1" xsi:schemaLocation="info:srw/schema/1/dc-v1.1 http://www.loc.gov/standards/sru/dc-schema.xsd" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> <dc:title>統計検定1級・準1級公式問題集 : 日本統計学会公式認定</dc:title> <dc:creator>日本統計学会出版企画委員会 編,統計質保証推進協会統計検定センター 著</dc:creator> <dc:subject>統計学</dc:subject> <dc:description>NDC（9版）はNDC（10版）を自動変換した値である。</dc:description> <dc:publisher>実務教育出版</dc:publisher> <dc:language>jpn</dc:language> </srw_dc:dc>
</recordData>
<recordPosition>1</recordPosition>
</record>
</records>
</searchRetrieveResponse>
EOS

    ret = Book.parse_xml(xml_code)    
    assert ret['title'] == '統計検定1級・準1級公式問題集 : 日本統計学会公式認定'
    assert ret['creator'] == '日本統計学会出版企画委員会 編,統計質保証推進協会統計検定センター 著'
    assert ret['publisher'] == '実務教育出版'
  end

  # test "search_NDL" do
  #   # 国会図書館API
  #   ret = Book.search_NDL('9784788925489')
  #   assert ret['title'] == '統計検定1級・準1級公式問題集 : 日本統計学会公式認定'
  #   assert ret['creator'] == '日本統計学会出版企画委員会 編,統計質保証推進協会統計検定センター 著'
  #   assert ret['publisher'] == '実務教育出版'
  # end

  test "need creator" do
    book = Book.create(
      creator: '',
      title: '',
      publisher: '',
      isbn: ''
    )
    
    assert_not book.save()
  end
end
