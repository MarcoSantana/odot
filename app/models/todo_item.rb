class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates_presence_of :content
  validates_length_of :content, minimum: 3, maximum: 256

  def completed?
    # Podemos usar los atributos directamente si referenciar en específico al objeto
    # .blank? de estar vacío devuelve verdadero y nuestra función pregunta "está completo?" por lo tanto devolvemos el valor contrario a blank
    !completed_at.blank?
  end
end
