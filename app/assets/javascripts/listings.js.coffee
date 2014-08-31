$ ->
  data = '[{"type":"Feature","geometry":{"type":"Point","coordinates":[-77.03238901390978,38.913188059745586]},"properties":{"title":"Mapbox DC","address":"1714 14th St NW, Washington DC","marker-color":"#fc4353","marker-size":"large","marker-symbol":"monument"}}]'
  geojson = $.parseJSON(data)
  $.ajax
    dataType: 'text'
    url: location.pathname + '.json'
    success: (data) ->
      geojson = $.parseJSON(data)
              
    L.mapbox.accessToken = 'pk.eyJ1IjoibWVyY2FkbGFuIiwiYSI6Im1YM2pkMjAifQ.mb8ZwDfm_mZJzwkhowQUFg'
    map = L.mapbox.map('map', 'mercadlan.jb969987').setView([40.783084, -73.965307], 15);
                          
    map.on 'layeradd', (e) ->
      map.featureLayer.eachLayer (marker) ->
       if marker.feature.properties.title is geojson[0].properties.title
         marker.openPopup()
    map.featureLayer.on 'layeradd', (e) ->
      marker = e.layer
      properties = marker.feature.properties
      popupContent =  '<div class="popup">' +
                       '<h3>' + properties.title + '</h3>' +
                       '<p>' + properties.address + '</p>' +
                      '</div>'
      marker.bindPopup popupContent,
        closeButton: false
        minWidth: 320
      marker.openPopup()

    map.featureLayer.setGeoJSON(geojson)
