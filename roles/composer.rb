name "composer"
description "Configure composer."
run_list(
  "recipe[php]",
  "recipe[composer]",
)
