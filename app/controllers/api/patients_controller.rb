class Api::PatientsController < ApplicationController
    before_action :set_patient, only: [:show, :update, :destroy]
  
    def index
      @patients = Patient.all
      render json: @patients
    end
  
    def show
      render json: @patient
    end
  
    def create
      @patient = Patient.new(patient_params)
      if @patient.save
        render json: @patient, status: :created
      else
        render json: @patient.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @patient.update(patient_params)
        render json: @patient
      else
        render json: @patient.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @patient.destroy
    end
  
    def stats
      stats = Patient.group("EXTRACT(DOW FROM created_at)").count
      weekday_stats = Hash.new(0)
    
      stats.each do |day, count|
        weekday_name = Date::DAYNAMES[day.to_i]
        weekday_stats[weekday_name] = count
      end
    
      render json: weekday_stats
    end
  
    private
  
    def set_patient
      @patient = Patient.find(params[:id])
    end
  
    def patient_params
      params.require(:patient).permit(:name, :email, :phone, :address)
    end
  end