components {
  id: "screen_factory"
  component: "/monarch/screen_factory.script"
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
    value: "play"
    type: PROPERTY_TYPE_HASH
  }
  property_decls {
  }
}
embedded_components {
  id: "collectionfactory"
  type: "collectionfactory"
  data: "prototype: \"/scenes/play/play.collection\"\nload_dynamically: false\ndynamic_prototype: false\n"
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
