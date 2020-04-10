class ThanksMailer < ApplicationMailer
	def send_mail(user)
		@user = user #ユーザー情報
		mail to: user.email, subject: '新規登録ありがとうございます'
	end
end
