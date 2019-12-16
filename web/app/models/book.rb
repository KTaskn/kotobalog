require 'rexml/document'

class Book < ApplicationRecord
    validates :creator, length: { maximum: 100 }, presence: true
    validates :title, length: { maximum: 200 }
    validates :publisher, length: { maximum: 100 }
    validates :isbn, length: { maximum: 13 }


    def self.parse_xml(xml_code)
        ret = {}
        ret['title'] = xml_code[/<dc:title>(.*)<\/dc:title>/, 1]
        ret['creator'] = xml_code[/<dc:creator>(.*)<\/dc:creator>/, 1]
        ret['publisher'] = xml_code[/<dc:publisher>(.*)<\/dc:publisher>/, 1]
        return ret
    end
end
