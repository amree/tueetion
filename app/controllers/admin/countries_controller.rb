class Admin::CountriesController < ApplicationController
  before_action :require_admin
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /admin/countries
  def index
    @countries = Country.all
  end

  # GET /admin/countries/1
  def show
  end

  # GET /admin/countries/new
  def new
    @country = Country.new
  end

  # GET /admin/countries/1/edit
  def edit
  end

  # POST /admin/countries
  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to [:admin, @country], notice: 'Country was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/countries/1
  def update
    if @country.update(country_params)
      redirect_to [:admin, @country], notice: 'Country was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/countries/1
  def destroy
    @country.destroy

    redirect_to admin_countries_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_country
    @country = Country.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def country_params
    params.require(:country).permit(:name, :calling_code, :sms_rate, :is_active)
  end
end
