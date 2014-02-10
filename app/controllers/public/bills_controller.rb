class Public::BillsController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    @bill = Student.find_by_public_key(params[:student_id])
                   .bills
                   .find(params[:id])

    respond_to do |format|
      format.pdf do
        render pdf: params[:id],
               orientation: 'Landscape',
               page_size: 'A5',
               template: 'bills/show.pdf.haml'
      end
    end
  end
end
