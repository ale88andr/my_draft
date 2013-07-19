class Book < ActiveRecord::Base

	#web form access
	attr_accessible :title, :author, :description, :year, :publisher, :language, :number_of_pages, :ISBN10, :ISBN13, :link_to_book, :category_of_book, :book_img, :book_category_ids

	has_and_belongs_to_many :book_categories, association_foreign_key: 'book_categories_id'

	#validations
	VALID_LINK_FORMAT = /(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:+#]*[\w\-\@?^=%&amp;+#])?/i

	validates :title, presence:{ message: " - Это поле должно быть заполненно" }, uniqueness:{ message: " - Книга с таким названием уже существует" }, length: { maximum: 255, too_long: " - Слишком длинное название гниги" }
	validates :author, presence: { message: " - У каждой книги есть автор! Укажите его" }, length: { maximum: 255, too_long: " - Слишком длинное имя автора, попробуйте что-нибудь покороче" }
	validates :year, presence: { message: " - Укажите год издания книги" }, numericality: { only_integer: " - Это поле должно содержать только цифровые значения", less_than_or_equal_to: Date.current.year }
	validates :publisher, presence: { message: " - У каждой книги есть издатель! Укажите его" }, length: { maximum: 255, too_long: " - Слишком длинное название, попробуйте что-нибудь покороче" }
	validates :number_of_pages, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только цифровые значения" }
	validates :ISBN10, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только цифровые значения"}, length: { is: 10, too_long: " - Номер ISBN10 должен состоять из 10 цифр" }
	validates :ISBN13, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только цифровые значения"}, length: { is: 13, too_long: " - Номер ISBN13 должен состоять из 13 цифр" }
	validates :link_to_book, allow_blank: true, format: { with: VALID_LINK_FORMAT, message: " - Это поле должно содержать ссылку"}
	validates :category_of_book, allow_nil: true, numericality: { only_integer: " - Это поле должно содержать только цифровые значения" }

	#uploader
	mount_uploader :book_img, BookCoverUploader

end