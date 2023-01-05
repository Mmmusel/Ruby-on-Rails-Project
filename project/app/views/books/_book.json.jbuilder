json.extract! book, :id, :user_id, :bookname, :bookaddress, :bookmobile, :created_at, :updated_at
json.url book_url(book, format: :json)
