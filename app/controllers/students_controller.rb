class StudentsController < ApplicationController
    # Create, read, update and delete Students
    def index
        students = Student.all
        render json: students,  status: :ok
      end
      
      def create
        student = Student.new(name: params[:name], age: params[:age], major: params[:major])
         if student.valid? && student.save
          render json: student, status: :created
        else
            render json: {error: "Student not Created"}, status: :unprocessable_entity
        end
      end
      
     
      
      
      

      def update
        student = Student.find_by(id: params[:id])
        if student
          student.name = params[:name]
          if student.valid? && student.save
            render json: student, serializer: StudentSerializer, status: :ok
          else
            render json: { errors: "Student Not Updated" }, status: :unprocessable_entity
          end
        else
          render json: { error: "student not found" }, status: :not_found
        end
      end
      
      

      def show
        student = Student.find_by(id: params[:id])
        if student
          render json: student, serializer: StudentSerializer, status: :ok
        else 
          render json: { error: "Student not found" }, status: :not_found
        end
      end
      
      def destroy
        student = Student.find_by(id: params[:id])
        if student
          student.destroy
          head :no_content
        else
          render json: { error: "Student not found" }, status: :not_found
        end
      end
      
end
