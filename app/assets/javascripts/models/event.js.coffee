# for more details see: http://emberjs.com/guides/models/defining-models/

Yaroom.Event = DS.Model.extend
  name: DS.attr 'string'
  from: DS.attr 'date'
  to: DS.attr 'date'
  type: DS.attr 'number'
  description: DS.attr 'string'
  subtext: DS.attr 'string'
  image: DS.attr 'string'
