class AcceptNewPeronaJob < ApplicationJob
  queue_as :default

  def perform(persona_id)
    persona = Persona.find(persona_id)
    if persona && persona.accepted == false
      persona.update(accepted: true)
    end
  end
end
