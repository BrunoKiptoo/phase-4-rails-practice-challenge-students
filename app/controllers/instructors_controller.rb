


class InstructorsController < ApplicationController

   

    # Create, read, update and delete Instructors

    def index
        instructors = Instructor.all
        render json: instructors,  status: :ok
      end
      
      def create
        instructor = Instructor.create(name: params[:name])
        if instructor.valid? && instructor.save
          render json: instructor, each_serializer: :InstructorSerializer, status: :created
        else
          render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      

      def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
          instructor.name = params[:name]
          if instructor.valid? && instructor.save
            render json: instructor, serializer: InstructorSerializer, status: :ok
          else
            render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "Instructor not found" }, status: :not_found
        end
      end
      
      

      def show
        instructor = Instructor.find_by(id: params[:id])
        if instructor
          render json: instructor, include: :students, serializer: InstructorSerializer, status: :ok
        else 
          render json: { error: "Instructor not found" }, status: :not_found
        end
      end
      
      def destroy
        instructor = Instructor.find_by(id: params[:id])
        if instructor
          instructor.destroy
          head :no_content
        else
          render json: { error: "Instructor not found" }, status: :not_found
        end
      end
      
end
