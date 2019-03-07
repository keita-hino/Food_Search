require 'rails_helper'

describe Command do
  before do
    @command = Command.new
  end
  describe '.get_another_text' do
    it 'オウム返しする' do
      message = {
        type:'text',
        text:'test'
      }
      expect(@command.get_another_text("test")).to eq(message)
    end
  end

  describe '.get_search_form' do
    it '検索用のリンクを含んだメッセージを返す' do
      message = {
        type: "flex",
        altText: "this is a flex message",
        contents: {
          type: "bubble",
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: "検索したい商品を入力してください",
                weight: "bold",
                size: "md",
                wrap: true
              },
              {
                type: "box",
                layout: "vertical",
                margin: "md",
                contents: [
                  {
                    type: "button",
                    style: "link",
                    height: "sm",
                    action: {
                      type: "uri",
                      label: "商品検索画面へ",
                      uri: ENV['LIFF_URL']
                    }
                  }
                ]
              }
            ]
          }
        }
      }
      expect(@command.get_search_form).to eq(message)
    end
  end


end
