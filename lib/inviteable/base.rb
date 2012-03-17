require 'active_record'

# Invitable
module Inviteable
  module Base #:nodoc:

    def self.included(base)
      base.extend ClassMethods 
    end
    
    module ClassMethods
      def acts_as_invitable
        has_many :invites, :dependent => :destroy

        has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
        belongs_to :invitation

        before_create :set_invitation_limit
        
        include EntropiSocial::Commentable::Base::InstanceMethods
        
      end
    end
    
    module InstanceMethods

      def invitation_token
        invitation.token if invitation
      end

      def invitation_token=(token)
        self.invitation = Invitation.find_by_token(token)
      end

      private

        def set_invitation_limit
          self.invitation_limit = 10
        end
    end

  end
end

ActiveRecord::Base.send(:include, Inviteable::Base)