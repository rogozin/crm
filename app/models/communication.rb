class Communication < ActiveRecord::Base
  belongs_to :ownerable, :polymorphic => true, :primary_key=>:id
end
