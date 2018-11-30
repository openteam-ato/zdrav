SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :declaration_supports, 'Поддержка декларации', manage_declaration_supports_path,
      highlights_on: /\A\/manage\/declaration_supports/ if current_user.manager? || current_user.admin?

    primary.item :thanks, 'Благодарности пациентов', manage_thanks_path,
      highlights_on: /\A\/manage(\z|\/thanks)/ if current_user.manager? || current_user.admin?

    primary.item :doctors, 'Земский доктор', manage_doctors_path,
      highlights_on: /\A\/manage\/doctors/ if current_user.manager? || current_user.admin?

    primary.item :evaluation_registries, "Поликлиника </br>начинается </br>с регистратуры".html_safe, manage_evaluation_registries_path,
      highlights_on: /\A\/manage\/evaluation_registries/ if current_user.manager? || current_user.admin?

    primary.item :video_messages, "Видео </br>обращения".html_safe, manage_video_messages_path,
      highlights_on: /\A\/manage\/video_messages/ if current_user.manager? || current_user.admin?

    primary.item :eco_coupons, 'ЭКО талоны', eco_coupons_path,
      highlights_on: /\A\/eco\/coupons/ if current_user.operator? || current_user.admin?

    primary.item :users, 'Пользователи', manage_users_path,
      highlights_on: /\A\/manage\/users/ if current_user.admin?

    primary.item :claims, 'Заявки', manage_claims_path,
      highlights_on: /\A\/manage\/claims/ if can? :manage, current_user

    primary.item :human_reserv_claims, "Резерв </br>кадров".html_safe, manage_human_reserv_claims_path,
      highlights_on: /\A\/manage\/human_reserv_claims/ if can? :manage, current_user
  end
end
