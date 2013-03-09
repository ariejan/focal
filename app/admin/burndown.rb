ActiveAdmin.register Burndown do
  form do |f|
    f.inputs do
      f.input :name
      f.input :pivotal_token,
        label: "Pivotal Tracker API Token"
      f.input :pivotal_project_id,
        label: "Pivotal Tracker Project ID"
    end

    f.actions
  end
end
