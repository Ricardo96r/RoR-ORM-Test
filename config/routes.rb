Rails.application.routes.draw do
  get 'home/Acerca'
  get 'home/Contacto'
  root 'metrics#index'
  get 'metrics/tiempo_medio_de_respuesta'
  get 'metrics/utilizacion_media_del_procesador'
  get 'metrics/capacidad_de_procesamiento_de_transacciones'
  get 'metrics/rendimiento_medio'
  get 'metrics/cantidad_media_de_memoria_utilizada'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
