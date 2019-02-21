class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	# 投稿データの保存
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = 'Book was successfully created.'
			# Book詳細ページへ
			redirect_to book_path(@book.id)
		else
			@user = current_user
			@books = Book.all
			render :index
		end
	end

	# Book詳細ページ
	def show
		@book = Book.new
		@books = Book.find(params[:id])
		@user = User.find(@books.user_id)
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		# book_paramsを追加してエラー回避
		if @book.update(book_params)
			flash[:notice] = 'Book was successfully update.'
			# Book詳細ページへ
			redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		if book.destroy
			flash[:notice] = 'Book was successfully destroyed.'
			# Books一覧ページへリダイレクト
			redirect_to books_path
		end
	end

	private

	def book_params
		params.require(:book).permit(:title, :opinion)
	end
end
