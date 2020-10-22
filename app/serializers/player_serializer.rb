class PlayerSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :player, :current, :buy, :sell, :mail, :buyed, :img, :tp, :notif
    
end
