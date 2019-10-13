require 'rexml/document'

class Book < ApplicationRecord
    validates :creator, presence: true
    def self.parse_xml(xml_code)
        ret = {}
        ret['title'] = xml_code[/<dc:title>(.*)<\/dc:title>/, 1]
        ret['creator'] = xml_code[/<dc:creator>(.*)<\/dc:creator>/, 1]
        ret['publisher'] = xml_code[/<dc:publisher>(.*)<\/dc:publisher>/, 1]
        return ret
    end
end
