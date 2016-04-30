class TodoItem < ActiveRecord::Base
  belongs_to :todo_list, dependent: :destroy
  has_paper_trail
  validates_presence_of :content
  validates_length_of :content, minimum: 3, maximum: 256

  scope :complete, -> { where("completed_at is not null")  }#This is the text passed directly to the datbase
  scope :incomplete, -> { where(completed_at: nil)  }#rails way

  def completed?
    # Podemos usar los atributos directamente si referenciar en específico al objeto
    # .blank? de estar vacío devuelve verdadero y nuestra función pregunta "está completo?" por lo tanto devolvemos el valor contrario a blank
    !completed_at.blank?
  end
end
