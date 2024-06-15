components {
  id: "screen_factory"
  component: "/.defold/assets/monarch/screen_factory.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "screen_id"
    value: "popup_start_player_form"
    type: PROPERTY_TYPE_HASH
  }
  properties {
    id: "popup"
    value: "true"
    type: PROPERTY_TYPE_BOOLEAN
  }
  property_decls {
  }
}
embedded_components {
  id: "collectionfactory"
  type: "collectionfactory"
  data: "prototype: \"/scenes/popup_start_player_form/popup_start_player_form.collection\"\nload_dynamically: false\ndynamic_prototype: false\n"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
