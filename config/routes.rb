Rails.application.routes.draw do
  get 'home/Acerca'
  get 'home/Contacto'
  root 'metrics#index'
  get 'metrics/tiempo_de_respuesta'
  get 'metrics/utilizacion_de_cache'
  get 'metrics/capacidad'
  get 'metrics/rendimiento'
  get 'metrics/utilizacion_de_memoria'
  get 'metrics/velocidad_bajo_estres'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
