// cf https://www.w3schools.com/graphics/google_maps_events.asp
function myMap(latitude, longitude) {
	var mapProp= new google.maps.LatLng( latitude , longitude );

	var map=new google.maps.Map(document.getElementById("gmap"),
		{center: mapProp ,
			zoom: 4});

	// add marker
	var marker = new google.maps.Marker({position: mapProp});
	marker.setMap(map);

	// add message when clicking
	var infowindow = new google.maps.InfoWindow({
		content: '<%= @map.message%>'
	});
	google.maps.event.addListener(marker, 'click', function() {
		infowindow.open(map,marker);
	});
}