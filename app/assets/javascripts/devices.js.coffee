# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

getUrlParam = (x) ->
  query = window.location.search.substr(1)
  postion = query.indexOf('=')
  name = query.substr(postion+1)

$(document).ready ->
  name = getUrlParam(name)
  $.ajax({
    type: "POST",
    url: "/locations.json",
    data: { name: name},
    dataType: 'json',
    success:(location_json) ->
      mapObj = new AMap.Map("iCenter", {
        center:new AMap.LngLat(location_json.longitude,location_json.latitude),
        level:13
      })
      marker = new AMap.Marker({
        position:mapObj.getCenter(),
        draggable:true,
        cursor:'move'
      });
      marker.setMap(mapObj);
      marker.setAnimation('AMAP_ANIMATION_BOUNCE');
  })
