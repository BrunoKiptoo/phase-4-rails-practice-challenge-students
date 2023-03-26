class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :major
end
