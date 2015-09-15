module CouponHistory
  def history
    hash = {}
    versions.each do |version|
      version_object = version.reify # текущий объект
      user = User.find(version.whodunnit)
      if version_object.nil?
        hash[version.created_at] = "пользователь #{user.name} создал талон, изменил #{human_action_list(version.changeset)}"
      else
        hash[version.created_at] = "пользователь #{user.name} изменил #{human_action_list(version.changeset)}"
      end
    end

    hash
  end

  def human_action_list(changeset)
    human_action_list = []
    changeset.except(:updated_at, :created_at).each do |key, value|
      value_previous, value_next = value

      # даты
      if value_previous.nil? && value_next.is_a?(Date)
        human_action_list << I18n.t("coupon.#{key}") + " на #{I18n.l(value_next, :format => :long)}"
      elsif value_previous.is_a?(Date) && value_next.is_a?(Date)
        human_action_list << I18n.t("coupon.#{key}") + " c #{I18n.l(value_previous, :format => :long)} на #{I18n.l(value_next, :format => :long)}"
      elsif value_previous.is_a?(Date) && value_next.nil?
        human_action_list << I18n.t("coupon.#{key}") + " на #{I18n.l(value_previous, :format => :long)}"
      end

      # статусы
      if key == "workflow_state"
        if value_previous.nil?
          human_action_list <<  I18n.t("coupon.#{key}") + " на &laquo;" + I18n.t("coupon.#{value_next}") + "&raquo;"
        else
          human_action_list <<  I18n.t("coupon.#{key}") + " c &laquo;" + I18n.t("coupon.#{value_previous}") + "&raquo; на &laquo;" + I18n.t("coupon.#{value_next}") + "&raquo;"
        end
      end

      # МУ
      if key == "medical_institution_id"
        if value_previous.nil? && value_next
          mi = MedicalInstitution.find(value_next)
          human_action_list << I18n.t("coupon.#{key}") + " на &laquo;#{mi.title}&raquo;"
        elsif value_previous && value_next
          mi_prev = MedicalInstitution.find(value_previous)
          mi_next = MedicalInstitution.find(value_next)
          human_action_list << I18n.t("coupon.#{key}") + " с &laquo;#{mi_prev.title}&raquo; на &laquo;#{mi_next.title}&raquo;"
        else
          mi = MedicalInstitution.find(value_next)
          human_action_list << I18n.t("coupon.#{key}") + " &laquo;на #{mi.title}&raquo;"
        end
      end
      # пациент
      if key == 'patient_id'
        if value_previous.nil? && value_next
          patient = Patient.find(value_next)
          human_action_list << I18n.t("coupon.#{key}") + " на &laquo;#{patient.code}&raquo;"
        elsif value_previous && value_next
          patient_prev = Patient.find(value_previous)
          patient_next = Patient.find(value_next)
          human_action_list << I18n.t("coupon.#{key}") + " с &laquo;#{patient_prev.code}&raquo; на &laquo;#{patient_next.code}&raquo;"
        else
          patient = Patient.find(value_previous)
          human_action_list << I18n.t("coupon.#{key}") + " &laquo;на #{patient.code}&raquo;"
        end
      end
    end

    human_action_list.join(", ")
  end
end
